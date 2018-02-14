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

    it { expect(tree.list).to match_array([temp_string, array_of_words].flatten) }
  end

  describe '#save_to_file' do
    let!(:file_path) { stub_const('Tree::FILE_PATH', 'spec/support/support_save.txt') }
    after(:each) { File.delete(file_path) }

    it 'it have to save words to file' do
      %w[abc kefir moloko].each { |word| tree.add(word) }
      tree.save_to_file
      expect(tree.list).to match_array(File.readlines(file_path).map(&:chomp))
    end
  end

  describe '#load_from_file' do
    let!(:file_path) { stub_const('Tree::FILE_PATH', 'spec/support/support_load.txt') }

    it 'it have to load words from file' do
      tree.load_from_file
      expect(tree.list).to match_array(File.readlines(file_path).map(&:chomp))
    end
  end

  describe do
    let(:file_path) { stub_const('Tree::FILE_PATH', 'spec/support/support.txt') }
    let(:zip_file_path) { stub_const('Tree::ZIP_FILE_PATH', 'spec/support/support.zip') }
    let(:zip_temp_path) { stub_const('Tree::ZIP_TEMP_PATH', 'spec/support/support_zip.txt') }
    let(:join_file_path) { stub_const('Tree::JOIN_FILE_PATH', File.join('spec/support', 'support_zip.txt')) }
    let(:param) { stub_const('Tree::PARAM', 'support.txt') }

    describe '#save_to_zip_file' do
      it 'file have to exist' do
        %w[abc kefir moloko].each { |word| tree.add(word) }
        tree.save_to_zip_file(zip_file_path, zip_temp_path, param, join_file_path)
        expect(File.exist?('spec/support/support.zip')).to eq true
      end
    end

    describe '#load_from_zip_file' do
      it 'it should add words to tree from zip file' do
        tree.load_from_zip_file(file_path, zip_file_path, zip_temp_path, param, join_file_path)
        expect(tree.list).to match_array(%w[abc kefir moloko])
      end
    end
  end
end
