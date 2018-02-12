require 'rspec'
require_relative '../prefix_tree'

RSpec.describe Tree do
  let(:temp_string) { 'abc' }
  let(:tree) { described_class.new }

  describe '#add' do
    it 'it return keys of child arrays' do
      tree.add(temp_string)
      current_node = tree.instance_variable_get(:@root_node)
      result_string = temp_string.chars.map do |_node|
        current_node = current_node.children[0]
        current_node.key
      end.join

      expect(result_string).to eq(temp_string)
    end
  end
  describe '#include?' do
    it 'true if prefix tree include word and false if there is no word' do
      tree.add(temp_string)
      expect(tree.include?('abc')).to be_truthy
      expect(tree.include?('acb')).to be_falsey
      expect(tree.include?('abcd')).to be_falsey
    end
  end
end
