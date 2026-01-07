# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'
require_relative '../../../../lib/rubocop/cop/chef/no_execute_resource'

RSpec.describe RuboCop::Cop::Chef::NoExecuteResource do
  subject(:cop) { described_class.new }

 it 'registers an offense when execute resource is used' do
  expect_offense(<<~RUBY)
    execute 'install nginx' do
    ^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef/NoExecuteResource: Avoid using execute resource for package installation. Use package resource instead.
      command 'apt-get install nginx'
    end
  RUBY
end


  it 'does not register an offense for package resource' do
    expect_no_offenses(<<~RUBY)
      package 'nginx'
    RUBY
  end
end
