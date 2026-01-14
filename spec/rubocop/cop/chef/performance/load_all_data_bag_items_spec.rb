require 'spec_helper'

describe RuboCop::Cop::Chef::Performance::LoadAllDataBagItems do
  subject(:cop) { described_class.new }

  it 'registers an offense for search with "*:*"' do
    expect_offense(<<~RUBY)
      search(:users, '*:*')
      ^^^^^^^^^^^^^^^^^^^^^ Chef/Performance/LoadAllDataBagItems: Avoid loading all data bag items with broad or empty search queries which cause high IO and memory usage.
    RUBY
  end

  it 'registers an offense for search with empty string' do
    expect_offense(<<~RUBY)
      search(:my_bag, '')
      ^^^^^^^^^^^^^^^^^^^ Chef/Performance/LoadAllDataBagItems: Avoid loading all data bag items with broad or empty search queries which cause high IO and memory usage.
    RUBY
  end

  it 'does not register offense for specific search queries' do
    expect_no_offenses(<<~RUBY)
      search(:users, 'id:john')
    RUBY
  end

  it 'registers an offense for data_bag_search with empty query' do
    expect_offense(<<~RUBY)
      data_bag_search('users', '')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef/Performance/LoadAllDataBagItems: Avoid loading all data bag items with broad or empty search queries which cause high IO and memory usage.
    RUBY
  end

  it 'registers an offense for data_bag_search with "*:*"' do
    expect_offense(<<~RUBY)
      data_bag_search('users', '*:*')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef/Performance/LoadAllDataBagItems: Avoid loading all data bag items with broad or empty search queries which cause high IO and memory usage.
    RUBY
  end

  it 'does not register offense for data_bag_search with specific query' do
    expect_no_offenses(<<~RUBY)
      data_bag_search('users', 'id:john')
    RUBY
  end

  it 'does not register offense for search with nil query' do
    expect_no_offenses(<<~RUBY)
      search(:users, nil)
    RUBY
  end

  it 'does not register offense for search with variable query' do
    expect_no_offenses(<<~RUBY)
      query = '*:*'
      search(:users, query)
    RUBY
  end

  it 'does not register offense for unrelated method' do
    expect_no_offenses(<<~RUBY)
      something_else(:users, '*:*')
    RUBY
  end

  it 'registers an offense for search with whitespace-only query' do
    expect_offense(<<~RUBY)
      search(:users, '   ')
      ^^^^^^^^^^^^^^^^^^^^^ Chef/Performance/LoadAllDataBagItems: Avoid loading all data bag items with broad or empty search queries which cause high IO and memory usage.
    RUBY
  end
end
