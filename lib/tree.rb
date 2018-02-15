# create a tree structure
class Tree
  FILE_PATH = 'data/words.txt'.freeze
  ZIP_FILE_PATH = 'data/words.zip'.freeze
  ZIP_TEMP_PATH = 'data/zip_words.txt'.freeze

  def initialize
    @root_node = Node.new('')
  end

  def add(word)
    current = @root_node
    word.chars.each { |char| current = find_or_add_node(char, current) }
    current.end_of_word = true
  end

  def include?(word)
    current = @root_node
    word.chars.all? { |char| current = find_node(char, current) } && current.end_of_word
  end

  def list_with_parent
    perform_list_with_parent
  end

  def list_without_parent
    perform_list_without_parent
  end

  def load_from_file(file_path = FILE_PATH)
    File.readlines(file_path).each { |word| add(word.chomp) }
  end

  def save_to_file(file_path = FILE_PATH)
    File.open(file_path, 'a') { |file| perform_list_with_parent.each { |word| file.puts word } }
  end

  def save_to_zip_file(zip_file_path = ZIP_FILE_PATH, zip_temp_path = ZIP_TEMP_PATH)
    File.delete(zip_file_path) if File.exist?(zip_file_path)
    save_to_file(zip_temp_path)
    Zip::File.open(zip_file_path, Zip::File::CREATE) { |zip| zip.add('words.txt', File.join(zip_temp_path)) }
    File.delete(zip_temp_path)
  end

  def load_from_zip_file(zip_file_path = ZIP_FILE_PATH, zip_temp_path = ZIP_TEMP_PATH)
    Zip::File.open(zip_file_path) { |zip_file| zip_file.extract('words.txt', File.join(zip_temp_path)) }
    load_from_file(zip_temp_path)
    File.delete(zip_temp_path)
  end

  private

  def perform_list_without_parent(current = @root_node, word = '', words = [])
    current.children.each do |node|
      temp_word = word.dup
      temp_word << node.key
      perform_list_without_parent(node, temp_word, words)
    end
    words << word if current.end_of_word
    words
  end

  def perform_list_with_parent(words = [], current = @root_node)
    current.children.each { |node| perform_list_with_parent(words, node) }
    words << current.to_s if current.end_of_word
    words
  end

  def find_or_add_node(letter, tree)
    find_node(letter, tree) || add_node(letter, tree)
  end

  def add_node(letter, tree)
    Node.new(letter, tree).tap { |node| tree.children << node }
  end

  def find_node(letter, tree)
    tree.children.find { |node| node.key.eql? letter }
  end
end
