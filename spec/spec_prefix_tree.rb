require 'rspec'
require_relative '../prefix_tree'

RSpec.describe Tree do
  it 'it return keys of child arrays' do
    tree = Tree.new
    tree.add('abc')
    expect(tree.instance_variable_get(:@first_node).key).to eq('*')
    expect(tree.instance_variable_get(:@first_node).array[0].key).to eq('a')
    expect(tree.instance_variable_get(:@first_node).array[0].array[0].key).to eq('b')
    expect(tree.instance_variable_get(:@first_node).array[0].array[0].array[0].key).to eq('c')
  end
end
