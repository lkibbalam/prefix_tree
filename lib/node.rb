# Node of the tree, have key-char, mark-end of the ford of and child-array
class Node
  attr_accessor :end_of_word, :key, :children, :parent

  def initialize(key, parent = nil)
    @key = key
    @parent = parent
    @end_of_word = false
    @children = []
  end

  def to_s
    parent.to_s + key
  end
end
