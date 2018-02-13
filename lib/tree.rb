# create a tree structure
class Tree
  FILE_PATH = 'data/words.txt'.freeze
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
    list_node
  end

  def load_from_file
    words = File.readlines(FILE_PATH).map(&:chomp)
    words.each { |word| add(word) }
  end

  def save_to_file
    current = @root_node
    words = []
    list_words(current, words)
    f = File.new(FILE_PATH, 'a')
    words.each { |word| f.puts word unless word.nil? }
    f.close
  end

  private

  def list_words(current = @root_node, words = [])
    current.children.each { |node| list_words(node, words) }
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
