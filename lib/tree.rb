# create a tree structure
class Tree
  def initialize
    @root_node = Node.new('')
  end

  def add(word, current = @root_node)
    word.chars.each { |char| current = find_or_add_node(char, current) }
    current.end_of_word = true
  end

  def include?(word, current = @root_node)
    word.chars.all? { |char| current = find_node(char, current) } && current.end_of_word
  end

  def list(current = @root_node, words = [])
    current.children.each { |node| list(node, words) }
    words << current.to_s if current.end_of_word
    words
  end

  private

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
