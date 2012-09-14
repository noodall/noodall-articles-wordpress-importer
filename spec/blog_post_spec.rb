gem 'minitest'

require 'minitest/autorun'
require 'minitest/pride'
require 'ostruct'

require_relative '../lib/noodall/articles/wordpress-importer/blog_post'

describe "Blog Post" do
  it "must correctly set attributes" do

    class Nokogiri::XML::Document
      def at_xpath(arg)
        value = case arg
        when /wp:status/
          "published"
        when /title/
          "A title"
        when /pubDate/
          "Pub date"
        when /wp:post_date/
          "Post date"
        when /dc:creator/
          "John Smith"
        when /excerpt:encoded/
          "This is the excerpt"
        when /content:encoded/
          "This is page content"
        end
        OpenStruct.new(:text => value) if value
      end
    end

    mock = Nokogiri::XML::Document.new

    post = Noodall::Articles::WordPressImporter::BlogPost.new(mock)
    post.status.must_equal "published"
    post.title.must_equal "A title"
    post.publish_date.must_equal "Pub date"
    post.post_date.must_equal "Post date"
    post.publish_date.must_be DateTime
    post.post_date.must_be DateTime
    post.creator.must_equal "John Smith"
    post.content.must_equal "This is page content"
    post.excerpt.must_equal "This is the excerpt"
  end

  it "must handles nil attributes" do

    class Nokogiri::XML::Document
      def at_xpath(arg)
        nil
      end
    end

    mock = Nokogiri::XML::Document.new

    post = Noodall::Articles::WordPressImporter::BlogPost.new(mock)
    post.status.must_equal nil
    post.title.must_equal nil
    post.publish_date.must_equal nil
    post.post_date.must_equal nil
    post.creator.must_equal nil
    post.content.must_equal nil
  end
end

