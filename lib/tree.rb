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

  def list
    perform_list
  end

  def load_from_file(path = FILE_PATH)
    File.readlines(path).each { |word| add(word.chomp) }
  end

  def save_to_file(path = FILE_PATH)
    File.open(path, 'a') { |file| perform_list.each { |word| file.puts word } }
  end

  def save_to_zip_file
    File.delete(ZIP_FILE_PATH) if File.exist?(ZIP_FILE_PATH)
    save_to_file(ZIP_TEMP_PATH)
    Zip::File.open(ZIP_FILE_PATH, Zip::File::CREATE) { |zip| zip.add('words.txt', File.join('data', 'zip_words.txt')) }
    File.delete(ZIP_TEMP_PATH)
  end

  def load_from_zip_file
    File.delete(FILE_PATH) if File.exist?(FILE_PATH)
    Zip::File.open(ZIP_FILE_PATH) { |zip_file| zip_file.extract('words.txt', File.join('data', 'zip_words.txt')) }
    load_from_file(ZIP_TEMP_PATH)
    File.delete(ZIP_TEMP_PATH)
  end

  private

  def perform_list(words = [], current = @root_node)
    current.children.each { |node| perform_list(words, node) }
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
