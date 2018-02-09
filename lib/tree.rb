# create a tree structure
class Tree
  def initialize
    @first_node = Node.new('*')
  end

  def add(word)
    chars = word.split('')
    current = @first_node
    chars.each { |char| current = add_char(char, current.array) }
    current.mark = true
  end

  private

  def add_char(letter, tree)
    find_char(letter, tree) || Node.new(letter).tap { |node| tree << node }
  end

  def find_char(letter, tree)
    tree.find { |node| node.key == letter }
  end
end
