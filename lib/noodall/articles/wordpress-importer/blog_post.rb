require 'nokogiri'
require 'sanitize'

module Noodall
  module Articles
    module WordPressImporter
      class BlogPost
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::TagHelper

        attr_accessor :status, :title, :content, :excerpt, :publish_date, :post_date, :creator, :categories

        def initialize(post)
          @post = post

          @status       = attribute_value('wp:status')
          @title        = attribute_value('title')
          @content      = attribute_value('content:encoded')
          @excerpt      = attribute_value('excerpt:encoded')
          @publish_date = parse_date(attribute_value('pubDate'))
          @post_date    = parse_date(attribute_value('wp:post_date'))
          @creator      = attribute_value('dc:creator')
          @categories   = attribute_value('category')
        end

        def content
          cleaned = Sanitize.clean(@content, Sanitize::Config::BASIC)
          simple_format(cleaned)
        end

        def categories
          @categories || []
        end

        private

        def attribute_value(xpath)
          value = @post.xpath(xpath)
          values = value.map { |v| v.text }
          values.size > 1 ? values.uniq : values.first
        end

        def parse_date(date)
          DateTime.parse(date.to_s)
        rescue ArgumentError
          ""
        end
      end
    end
  end
end

