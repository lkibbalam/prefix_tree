require 'zip'
require_relative 'lib/tree'
require_relative 'lib/node'

puts 'In future prefix tree will be here'
tree = Tree.new

tree.add('bca')
tree.add('cab')

p tree.include?('word')
p tree.include?('ababagalamaga')
p tree.list
