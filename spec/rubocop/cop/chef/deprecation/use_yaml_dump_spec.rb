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

describe RuboCop::Cop::Chef::ChefDeprecations::UseYamlDump, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using .to_yaml' do
    expect_offense(<<~RUBY)
      Foo.bar.to_yaml
      ^^^^^^^^^^^^^^^ Chef Infra Client 16.5 introduced performance enhancements to Ruby library loading. Due to the underlying implementation of Ruby's `.to_yaml` method, it does not automatically load the `yaml` library and `YAML.dump()` should be used instead to properly load the `yaml` library.
    RUBY

    expect_correction("YAML.dump(Foo.bar)\n")
  end
end
