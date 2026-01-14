require 'spec_helper'

describe RuboCop::Cop::Chef::Performance::RepeatedResourcesInLoops do
  subject(:cop) { described_class.new }

  it 'registers an offense for package creation in a loop' do
    expect_offense(<<~RUBY)
      %w(foo bar).each do |pkg|
        package pkg
        ^^^^^^^^^^^ Chef/Performance/RepeatedResourcesInLoops: Avoid creating resources inside loops when the resource supports arrays: use batched or bulk resources for efficiency.
      end
    RUBY
  end

  it 'does not register an offense for batched resource usage' do
    expect_no_offenses(<<~RUBY)
      package %w(foo bar)
    RUBY
  end

  it 'registers an offense for user creation in a loop' do
    expect_offense(<<~RUBY)
      %w(alice bob).each do |u|
        user u
        ^^^^^^ Chef/Performance/RepeatedResourcesInLoops: Avoid creating resources inside loops when the resource supports arrays: use batched or bulk resources for efficiency.
      end
    RUBY
  end

  it 'registers an offense for service creation in a loop' do
    expect_offense(<<~RUBY)
      %w(nginx apache).each do |svc|
        service svc
        ^^^^^^^^^^^ Chef/Performance/RepeatedResourcesInLoops: Avoid creating resources inside loops when the resource supports arrays: use batched or bulk resources for efficiency.
      end
    RUBY
  end

  it 'does not register an offense for unrelated resources in a loop' do
    expect_no_offenses(<<~RUBY)
      %w(foo bar).each do |item|
        file "/tmp/\#{item}"
      end
    RUBY
  end

  it 'does not register an offense for batchable resource outside a loop' do
    expect_no_offenses(<<~RUBY)
      user 'alice'
    RUBY
  end

  it 'registers an offense for group creation in a loop' do
    expect_offense(<<~RUBY)
      %w(admins users).each do |grp|
        group grp
        ^^^^^^^^^ Chef/Performance/RepeatedResourcesInLoops: Avoid creating resources inside loops when the resource supports arrays: use batched or bulk resources for efficiency.
      end
    RUBY
  end
end
