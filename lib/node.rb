# Node of the tree, have key-char, mark-end of the ford of and child-array
class Node
  attr_accessor :end_of_word
  attr_reader :key, :children
  def initialize(key)
    @key = key
    @end_of_word = false
    @children = []
  end
end
