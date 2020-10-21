# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

describe RuboCop::Cop::Chef::Deprecations::ChefDKGenerators, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using ChefDK::CLI.new' do
    expect_offense(<<~RUBY)
      ChefDK::CLI.new
      ^^^^^^ When writing cookbook generators use the ChefCLI module instead of the ChefDK module which was removed in Chef Workstation 0.8 and later.
    RUBY

    expect_correction("ChefCLI::CLI.new\n")
  end

  it 'registers an offense when using a ChefDK Generator class' do
    expect_offense(<<~RUBY)
      ChefDK::Generator::TemplateHelper
      ^^^^^^ When writing cookbook generators use the ChefCLI module instead of the ChefDK module which was removed in Chef Workstation 0.8 and later.
    RUBY

    expect_correction("ChefCLI::Generator::TemplateHelper\n")
  end

  it 'registers an offense when defining your own generators' do
    expect_offense(<<~RUBY)
      module ChefDK
             ^^^^^^ When writing cookbook generators use the ChefCLI module instead of the ChefDK module which was removed in Chef Workstation 0.8 and later.
        module Command
          module GeneratorCommands
            class Cookbook < Base
              def emit_post_create_message
                msg("my own thing")
              end
            end
          end
        end
      end
    RUBY

    expect_correction(<<~RUBY)
      module ChefCLI
        module Command
          module GeneratorCommands
            class Cookbook < Base
              def emit_post_create_message
                msg("my own thing")
              end
            end
          end
        end
      end
    RUBY
  end

  it "doesn't register an offense with a bare ChefDK const" do
    expect_no_offenses('ChefDK')
  end
end
