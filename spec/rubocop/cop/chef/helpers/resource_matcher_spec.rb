# frozen_string_literal: true
require 'spec_helper'

describe RuboCop::Cop::Chef::Helpers::ResourceMatcher do
  let(:dummy_class) { Class.new { include RuboCop::Cop::Chef::Helpers::ResourceMatcher } }
  let(:helper) { dummy_class.new }

  it 'identifies search calls correctly' do
    expect(helper.search_call?(parse_source('search(:users)').ast)).to be true
  end

  it 'detects batchable resources' do
    expect(helper.batchable_resource?(:package)).to be true
    expect(helper.batchable_resource?(:template)).to be false
  end
end
