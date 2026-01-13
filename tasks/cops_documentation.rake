# frozen_string_literal: true

begin
  require 'yard'
  require 'cookstyle'

  YARD::Rake::YardocTask.new(:yard_for_generate_documentation) do |task|
    task.files = ['lib/rubocop/cop/**/*.rb']
    task.options = ['--no-output']
  end

  desc 'Update cop count in the readme'
  task :update_readme_cop_count do
    def cop_count
      Dir.glob('lib/rubocop/cop/**/*.rb').count
    end

    contents = File.read('README.md').gsub(/ship \*\*\d* Chef/, "ship **#{cop_count} Chef")
    File.write('README.md', contents)
  end

  desc 'Generate yaml format docs of all Chef/InSpec cops for docs.chef.io'
  task generate_cops_yml_documentation: :yard_for_generate_documentation do
    def cops_of_department(cops, department)
      cops.with_department(department).sort!
    end

    def code_example(ruby_code)
      content = +"```ruby\n"
      content << ruby_code.text.strip
      content << "\n```\n"
      content
    end

    def write_yml(data)
      file_name = "#{Dir.pwd}/docs-chef-io/assets/cookstyle/cops_#{data['full_name'].to_s.downcase.tr('/', '_')}.yml"
      File.open(file_name, 'w') do |file|
        puts "* generated #{file_name}"
        file.write(YAML.dump(data))
      end
    end

    def examples(code_object)
      code_object.tags('example').first&.text
    end

    def main
      require 'yaml' unless defined?(YAML)
      all_cops = RuboCop::Cop::Cop.registry
      chef_departments = all_cops.departments.select { |d| d.start_with?('Chef', 'InSpec') }.sort
      config = RuboCop::ConfigLoader.load_file('config/default.yml')

      YARD::Registry.load!
      # for each department starting with "Chef"
      chef_departments.each do |department|
        # for each cop in the department from the list of all cops
        cops_of_department(all_cops, department).each do |cop|
          current_dir = File.join(Dir.pwd + File::SEPARATOR)
          YARD::Registry.all(:class).detect do |code_object|
            # find the yard data that matches our cop
            next unless RuboCop::Cop::Badge.for(code_object.to_s) == cop.badge

            cop_data = {}
            cop_data['short_name'] = cop.cop_name.split('/').last
            cop_data['full_name'] = cop.cop_name
            cop_data['department'] = cop.department.to_s
            cop_data['description'] = code_object.docstring.to_s unless code_object.docstring.blank?
            cop_data['autocorrection'] = cop.support_autocorrect?
            cop_data['target_chef_version'] =
              cop.respond_to?(:required_minimum_chef_version) ? "#{cop.required_minimum_chef_version}+" : 'All Versions'

            cop_data['examples'] = examples(code_object)

            config_data = config.for_cop(cop)
            cop_data['version_added'] = config_data['VersionAdded']
            cop_data['enabled'] = config_data['Enabled']
            if config_data['Exclude']
              cop_data['excluded_file_paths'] = config_data['Exclude'].map do |x|
                x.delete_prefix(current_dir)
              end
            end
            if config_data['Include']
              cop_data['included_file_paths'] = config_data['Include'].map do |x|
                x.delete_prefix(current_dir)
              end
            end

            write_yml(cop_data)
          end
        end
      end
    end

    main
  end

  desc 'Syntax check for the documentation comments'
  task documentation_syntax_check: :yard_for_generate_documentation do
    require 'parser/ruby25'

    ok = true
    YARD::Registry.load!
    cops = RuboCop::Cop::Cop.registry
    cops.each do |cop|
      examples = YARD::Registry.all(:class).find do |code_object|
        next unless RuboCop::Cop::Badge.for(code_object.to_s) == cop.badge

        break code_object.tags('example')
      end

      examples.to_a.each do |example|
        buffer = Parser::Source::Buffer.new('<code>', 1)
        buffer.source = example.text
        parser = Parser::Ruby25.new(RuboCop::AST::Builder.new)
        parser.diagnostics.all_errors_are_fatal = true
        parser.parse(buffer)
      rescue Parser::SyntaxError => e
        path = example.object.file
        puts "#{path}: Syntax Error in an example. #{e}"
        ok = false
      end
    end
    abort unless ok
  end
rescue LoadError
  puts "\n*** yard or cookstyle not available. bundle install to install yard and other dependencies\n\n"
end
