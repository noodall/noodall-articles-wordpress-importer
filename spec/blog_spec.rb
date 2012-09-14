gem 'minitest'

require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/noodall/articles/wordpress-importer/blog'
require_relative '../lib/noodall/articles/wordpress-importer/blog_post'

describe "Blog" do
  it "must raise an error if the export file does not exist" do
    lambda do
      Noodall::Articles::WordPressImporter::Blog.new("data/wordpress.xml2")
    end.must_raise Noodall::Articles::WordPressImporter::ExportFileMissingError
  end

  it "must raise an error if the export file is nil" do
    lambda do
      Noodall::Articles::WordPressImporter::Blog.new(nil)
    end.must_raise Noodall::Articles::WordPressImporter::ExportFileMissingError
  end

  it "must read an XML export file" do
    export = Noodall::Articles::WordPressImporter::Blog.new("data/wordpress.xml")
    export.posts.size.must_equal 1427
  end
end

