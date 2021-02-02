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
    File.open('README.md', 'w') { |file| file.write(contents) }
  end

  ###### SHARED DOCS HELPERS GO HERE ########
  ###### WHEN WE REMOVE THE MD DOCS IN THIS REPO MOVE THESE ######
  def cops_of_department(cops, department)
    cops.with_department(department).sort!
  end

  def code_example(ruby_code)
    content = +"```ruby\n"
    content << ruby_code.text.strip
    content << "\n```\n"
    content
  end
  ###### END SHARED DOCS HELPERS GO HERE ########

  desc 'Generate docs of all cops departments'
  task generate_cops_documentation: :yard_for_generate_documentation do
    def cops_body(config, cop, description, examples_objects, pars)
      content = h2(cop.cop_name)
      content << properties(config, cop)
      content << "#{description}\n"
      content << examples(examples_objects) if examples_objects.count > 0
      content << configurations(pars)
      content << references(config, cop)
      content
    end

    def print_cops_of_department(cops, department, config)
      selected_cops = cops_of_department(cops, department)

      return if selected_cops.count == 0

      content = +"# #{department}\n"
      selected_cops.each do |cop|
        content << print_cop_with_doc(cop, config)
      end
      file_name = "#{Dir.pwd}/docs/cops_#{department.to_s.downcase.tr('/', '_')}.md"
      File.open(file_name, 'w') do |file|
        puts "* generated #{file_name}"
        file.write(content.strip + "\n")
      end
    end

    def examples(examples_object)
      examples_object.each_with_object(h3('Examples').dup) do |example, content|
        content << h4(example.name) unless example.name == ''
        content << code_example(example)
      end
    end

    def properties(config, cop)
      header = ['Enabled by default', 'Supports autocorrection', 'Target Chef Version']
      enabled_by_default = config.for_cop(cop).fetch('Enabled')
      content = [[
        enabled_by_default ? 'Enabled' : 'Disabled',
        cop.support_autocorrect? ? 'Yes' : 'No',
        cop.respond_to?(:required_minimum_chef_version) ? "#{cop.required_minimum_chef_version}+" : 'All Versions',
      ]]
      to_table(header, content) + "\n"
    end

    def h2(title)
      content = +"\n"
      content << "## #{title}\n"
      content << "\n"
      content
    end

    def h3(title)
      content = +"\n"
      content << "### #{title}\n"
      content << "\n"
      content
    end

    def h4(title)
      content = +"#### #{title}\n"
      content << "\n"
      content
    end

    def configurations(pars)
      return '' if pars.empty?

      header = ['Name', 'Default value', 'Configurable values']
      configs = pars.each_key.reject { |key| key.start_with?('Supported') }
      content = configs.map do |name|
        configurable = configurable_values(pars, name)
        default = format_table_value(pars[name])
        [name, default, configurable]
      end

      h3('Configurable attributes') + to_table(header, content)
    end

    def configurable_values(pars, name)
      case name
      when /^Enforced/
        supported_style_name = RuboCop::Cop::Util.to_supported_styles(name)
        format_table_value(pars[supported_style_name])
      when 'IndentationWidth'
        'Integer'
      else
        case pars[name]
        when String
          'String'
        when Integer
          'Integer'
        when Float
          'Float'
        when true, false
          'Boolean'
        when Array
          'Array'
        else
          ''
        end
      end
    end
    # rubocop:enable

    def to_table(header, content)
      table = [
        header.join(' | '),
        Array.new(header.size, '---').join(' | '),
      ]
      table.concat(content.map { |c| c.join(' | ') })
      table.join("\n") + "\n"
    end

    def format_table_value(val)
      value =
        case val
        when Array
          if val.empty?
            '`[]`'
          else
            val.map { |config| format_table_value(config) }.join(', ')
          end
        else
          "`#{val.nil? ? '<none>' : val}`"
        end
      value.gsub("#{Dir.pwd}/", '').rstrip
    end

    def references(config, cop)
      urls = RuboCop::Cop::MessageAnnotator.new(config, cop.name, config.for_cop(cop), {}).urls
      return '' if urls.empty?

      content = h3('References')
      content << urls.map { |url| "* [#{url}](#{url})" }.join("\n")
      content << "\n"
      content
    end

    def print_cop_with_doc(cop, config)
      t = config.for_cop(cop)
      non_display_keys = %w(Description Enabled StyleGuide Reference)
      pars = t.reject { |k| non_display_keys.include? k }
      description = 'No documentation'
      examples_object = []
      YARD::Registry.all(:class).detect do |code_object|
        next unless RuboCop::Cop::Badge.for(code_object.to_s) == cop.badge

        description = code_object.docstring unless code_object.docstring.blank?
        examples_object = code_object.tags('example')
      end
      cops_body(config, cop, description, examples_object, pars)
    end

    def table_of_content_for_department(cops, department)
      selected_cops = cops_of_department(cops, department)
      return if selected_cops.count == 0

      filename = "cops_#{department.to_s.downcase.tr('/', '_')}.md"
      content = +"#### Department [#{department.to_s}](#{filename})\n\n"
      selected_cops.each do |cop|
        anchor = cop.cop_name.sub('/', '').downcase
        content << "* [#{cop.cop_name}](#{filename}##{anchor})\n"
      end

      content
    end

    def print_table_of_contents(cops, departments)
      path = "#{Dir.pwd}/docs/cops.md"

      content = +"<!-- START_COP_LIST -->\n"

      content << departments
                 .map { |department| table_of_content_for_department(cops, department) }
                 .reject(&:nil?)
                 .join("\n")
      content << "\n<!-- END_COP_LIST -->"

      File.write(path, content)
    end

    def main
      all_cops = RuboCop::Cop::Cop.registry
      chef_departments = all_cops.departments.select { |d| d.start_with?('Chef') }.sort
      config = RuboCop::ConfigLoader.load_file('config/default.yml')

      YARD::Registry.load!
      chef_departments.each do |department|
        print_cops_of_department(all_cops, department, config)
      end

      print_table_of_contents(all_cops, chef_departments)
    ensure
      RuboCop::ConfigLoader.default_configuration = nil
    end

    main
  end

  desc 'Generate yaml format docs of all Chef cops for docs.chef.io'
  task generate_cops_yml_documentation: :yard_for_generate_documentation do
    def write_yml(data)
      file_name = "#{Dir.pwd}/docs-chef-io/data/cookstyle/cops_#{data['name'].to_s.downcase.tr('/', '_')}.yml"
      File.open(file_name, 'w') do |file|
        puts "* generated #{file_name}"
        file.write(YAML.dump(data))
      end
    end

    def examples(code_object)
      ex = code_object.tags('example').first.text
      ex.gsub!('#### incorrect', "#### incorrect\n\n```ruby")
      ex.gsub!("\n#### correct", "```\n\n#### correct\n\n```ruby")
      ex << "\n```"
    rescue NoMethodError
      nil
    end

    def main
      require 'yaml' unless defined?(YAML)
      all_cops = RuboCop::Cop::Cop.registry
      chef_departments = all_cops.departments.select { |d| d.start_with?('Chef') }.sort

      YARD::Registry.load!
      # for each department starting with "Chef"
      chef_departments.each do |department|
        # for each cop in the department from the list of all cops
        cops_of_department(all_cops, department).each do |cop|
          YARD::Registry.all(:class).detect do |code_object|
            # find the yard data that matches our cop
            next unless RuboCop::Cop::Badge.for(code_object.to_s) == cop.badge

            cop_data = {}
            cop_data['name'] = cop.cop_name
            cop_data['department'] = cop.department.to_s
            cop_data['description'] = code_object.docstring.to_s unless code_object.docstring.blank?
            cop_data['examples'] = examples(code_object)

            write_yml(cop_data)
          end
        end
      end
    end

    main
  end

  desc 'Syntax check for the documentation comments'
  task documentation_syntax_check: :yard_for_generate_documentation do
    require 'parser/ruby24'

    ok = true
    YARD::Registry.load!
    cops = RuboCop::Cop::Cop.registry
    cops.each do |cop|
      examples = YARD::Registry.all(:class).find do |code_object|
        next unless RuboCop::Cop::Badge.for(code_object.to_s) == cop.badge

        break code_object.tags('example')
      end

      examples.to_a.each do |example|
        begin
          buffer = Parser::Source::Buffer.new('<code>', 1)
          buffer.source = example.text
          parser = Parser::Ruby24.new(RuboCop::AST::Builder.new)
          parser.diagnostics.all_errors_are_fatal = true
          parser.parse(buffer)
        rescue Parser::SyntaxError => e
          path = example.object.file
          puts "#{path}: Syntax Error in an example. #{e}"
          ok = false
        end
      end
    end
    abort unless ok
  end
rescue LoadError
  puts "\n*** yard or cookstyle not available. bundle install to install yard and other dependencies\n\n"
end
