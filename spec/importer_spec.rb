gem 'minitest'

require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/noodall/articles/wordpress-importer/importer.rb'
require_relative '../lib/noodall/articles/wordpress-importer/export_file.rb'

describe Blog do
  it "must raise an error if the export file does not exist" do
    lambda do
      export = Blog.new("data/wordpress.xml2")
      export.posts
    end.must_raise RuntimeError
  end

  it "must read an XML export file" do
    export = Blog.new("data/wordpress.xml")
    puts export.posts.class
    export.posts.size.must_equal 4
  end
end

