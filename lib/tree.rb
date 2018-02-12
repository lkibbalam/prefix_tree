# create a tree structure
class Tree
  def initialize
    @root_node = Node.new('')
  end

  def add(word, current = @root_node)
    chars = word.split('')
    chars.each { |char| current = find_or_add_node(char, current.children) }
    current.end_of_word = true
  end

  private

  def find_or_add_node(letter, tree)
    find_node(letter, tree) || Node.new(letter).tap { |node| tree << node }
  end

  def find_node(letter, tree)
    tree.find { |node| node.key == letter }
  end
end
