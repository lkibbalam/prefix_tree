require 'rspec'

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

  describe '#save_to_file' do
    let!(:file_path) { stub_const('Tree::FILE_PATH', 'spec/support/support.txt') }
    let(:array_of_words) { %w[kefir moloko] }
    let!(:push_to_tree) { array_of_words.each { |word| tree.add(word) } }
    let!(:save) { tree.save_to_file }
    let!(:array) { [] }
    let!(:file_words_to_array) do
      words = File.readlines(file_path).map(&:chomp)
      words.each { |word| array << word }
    end

    it 'it have to save words to file' do
      expect(tree.list).to match_array(array)
    end
  end

  describe '#load_from_file' do
    let!(:file_path) { stub_const('Tree::FILE_PATH', 'spec/support/support.txt') }
    let!(:load_words) { tree.load_from_file }
    let!(:array) { [] }
    let!(:file_words_to_array) do
      words = File.readlines(file_path).map(&:chomp)
      words.each { |word| array << word }
      File.delete(file_path)
    end

    it 'it have to load words from file' do
      expect(tree.list).to match_array(array)
    end
  end
end
