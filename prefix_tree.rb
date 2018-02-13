require_relative 'lib/tree'
require_relative 'lib/node'

puts 'In future prefix tree will be here'
tree = Tree.new
tree.add('word')
tree.add('words')
tree.add('worddd')
tree.add('sword')
tree.add('soap')
tree.add('dog')
tree.add('iguana')

p tree.include?('word')
p tree.include?('ababagalamaga')

p tree.list
tree.save_to_file
tree.load_from_file
