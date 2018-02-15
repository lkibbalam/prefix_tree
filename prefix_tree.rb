require 'zip'
require_relative 'lib/tree'
require_relative 'lib/node'

puts 'In future prefix tree will be here'
tree = Tree.new
tree.add('b')
tree.add('c')
tree.add('bca')
tree.add('bcasadas')
tree.add('bcadasdas')
tree.add('bcadasdasxzc')
tree.add('bcazxzcas')
tree.add('asdasdxzcxz')
tree.add('casdasdas')
tree.add('cagfhgfhn')
tree.add('cagfhdfl')

p tree.include?('word')
p tree.include?('ababagalamaga')

p tree.list_without_parent
p tree.list_with_parent
tree.save_to_zip_file
tree.load_from_zip_file
p tree.list_with_parent
p tree.list_without_parent
