# create a tree structure
class Tree
  FILE_PATH = 'data/words.txt'.freeze
  ZIP_FILE_PATH = 'data/words.zip'.freeze
  ZIP_TEMP_PATH = 'data/zip_words.txt'.freeze
  JOIN_FILE_PATH = File.join('data', 'zip_words.txt').freeze
  PARAM = 'words.txt'.freeze

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

  def save_to_zip_file(zip_file_path = ZIP_FILE_PATH, zip_temp_path = ZIP_TEMP_PATH, param = PARAM,
                       join_file_path = JOIN_FILE_PATH)

    File.delete(zip_file_path) if File.exist?(zip_file_path)
    save_to_file(zip_temp_path)
    Zip::File.open(zip_file_path, Zip::File::CREATE) { |zip| zip.add(param, join_file_path) }
    File.delete(zip_temp_path)
  end

  def load_from_zip_file(path = FILE_PATH, zip_file_path = ZIP_FILE_PATH, zip_temp_path = ZIP_TEMP_PATH, param = PARAM,
                         join_file_path = JOIN_FILE_PATH)

    File.delete(path) if File.exist?(path)
    Zip::File.open(zip_file_path) { |zip_file| zip_file.extract(param, join_file_path) }
    load_from_file(zip_temp_path)
    File.delete(zip_temp_path)
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
