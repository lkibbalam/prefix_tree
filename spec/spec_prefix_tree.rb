require 'rspec'
require_relative '../prefix_tree'

RSpec.describe Tree do
  let(:temp_string) { 'abc' }
  let(:tree) { described_class.new }
  let!(:add_to_tree) { tree.add(temp_string) }

  describe '#add' do
    it 'it return keys of child arrays' do
      current_node = tree.instance_variable_get(:@root_node)
      result_string = temp_string.chars.map do |_node|
        current_node = current_node.children[0]
        current_node.key
      end.join

      expect(result_string).to eq(temp_string)
    end
  end

  describe '#include?' do
    it { expect(tree.include?('abc')).to eq(true) }
    it { expect(tree.include?('acb')).to eq(false) }
    it { expect(tree.include?('abcd')).to eq(false) }
  end

  describe '#list' do
    let(:array_of_words) { %w[kefir moloko] }
    let!(:push_to_tree) { array_of_words.each { |word| tree.add(word) } }

    it do
      expect(tree.list).to match_array([temp_string, array_of_words].flatten)
    end
  end
end
