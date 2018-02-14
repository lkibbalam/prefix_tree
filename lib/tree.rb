# create a tree structure
class Tree
  FILE_PATH = 'data/words.txt'.freeze
  ZIP_FILE_PATH = 'data/words.zip'.freeze

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

  def load_from_file
    File.readlines(FILE_PATH).each { |word| add(word.chomp) }
  end

  def save_to_file
    File.open(FILE_PATH, 'a') { |file| perform_list.each { |word| file.puts word } }
  end

  def save_to_zip_file
    File.delete(ZIP_FILE_PATH) if File.exist?(ZIP_FILE_PATH)
    save_to_file
    Zip::File.open(ZIP_FILE_PATH, Zip::File::CREATE) { |z| z.add('words.txt', File.join('data', 'words.txt')) }
    File.delete('data/words.txt')
  end

  def load_from_zip_file
    File.delete('data/words.txt') if File.exist?('data/words.txt')
    Zip::File.open(ZIP_FILE_PATH) { |zip_file| zip_file.each { |entry| entry.extract('data/words.txt') } }
    load_from_file
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
