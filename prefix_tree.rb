require 'zip'
require_relative 'lib/tree'
require_relative 'lib/node'

tree = Tree.new
tree.add('ruby')
tree.add('elixir')
tree.add('rails')
tree.add('ababagalamaga')
tree.add('sharp')
tree.add('smalltalk')
tree.add('pascal')
tree.add('turbo')
tree.add('script')
tree.add('live')
tree.add('cristal')

p tree.include?('word')
p tree.include?('ababagalamaga')

p tree.list
tree.save_to_file
tree.load_from_file
tree.save_to_zip_file
tree.load_from_zip_file
p tree.list
