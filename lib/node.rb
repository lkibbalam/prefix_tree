# Node of the tree, have key-char, mark-end of the ford of and child-array
class Node
  attr_accessor :key, :array, :mark

  def initialize(key)
    @key = key
    @mark = false
    @array = []
  end
end
