require 'zip'
require_relative 'lib/tree'
require_relative 'lib/node'

puts 'In future prefix tree will be here'
tree = Tree.new
tree.add('worde')
tree.add('word')
tree.add('words')
tree.add('worddd')
tree.add('sword')
tree.add('soap')
tree.add('dog')
tree.add('iguana')

p tree.include?('word')
p tree.include?('ababagalamaga')

tree.save_to_zip_file
tree.load_from_zip_file
p tree.list
