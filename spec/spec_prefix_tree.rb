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
    let!(:add_to_tree) { tree.add(temp_string) }
    it { expect(tree.include?('abc')).to eq(true) }
    it { expect(tree.include?('acb')).to eq(false) }
    it { expect(tree.include?('abcd')).to eq(false) }
  end
end
