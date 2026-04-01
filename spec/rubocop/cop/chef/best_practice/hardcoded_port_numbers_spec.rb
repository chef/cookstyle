require 'spec_helper'

describe RuboCop::Cop::Chef::BestPractice::HardcodedPortNumbers, :config do
  it 'flags hardcoded port 8080' do
    expect_offense(<<~RUBY)
      8080
      ^^^^ Avoid hardcoding port numbers. Use node attributes instead for flexibility and easy reconfiguration.
    RUBY
  end

  it 'flags hardcoded port 5432' do
    expect_offense(<<~RUBY)
      5432
      ^^^^ Avoid hardcoding port numbers. Use node attributes instead for flexibility and easy reconfiguration.
    RUBY
  end

  it 'does not flag node attributes' do
    expect_no_offenses(<<~RUBY)
      node['port']
    RUBY
  end

  it 'flags port in service resource' do
    expect_offense(<<~RUBY)
      service 'nginx' do
        port 8080
             ^^^^ Avoid hardcoding port numbers. Use node attributes instead for flexibility and easy reconfiguration.
      end
    RUBY
  end

  it 'does not flag small numbers in arrays' do
    expect_no_offenses(<<~RUBY)
      x = 1
      y = 2
    RUBY
  end
end