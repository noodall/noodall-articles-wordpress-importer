require 'nokogiri'

module Noodall
  module Articles
    module WordPressImporter
      class Blog
        attr_accessor :posts, :export_file

        def initialize(export_file)
          @export_file = export_file.to_s
          @posts = load_posts
        end

        private

        def load_posts
          posts = []

          unless File.exists?(export_file)
            raise ExportFileMissingError
          end

          doc = Nokogiri::XML(File.read(export_file))
          doc.xpath('//item').each do |item|
            posts << BlogPost.new(item)
          end

          posts
        end
      end

      class ExportFileMissingError < StandardError
      end

      class MissingArticleListError < StandardError
      end
    end
  end
end

