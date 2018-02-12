require_relative 'lib/tree'
require_relative 'lib/node'

puts 'In future prefix tree will be here'
tree = Tree.new
p tree.add('word')

p tree.include?('word')
p tree.include?('ababagalamaga')
