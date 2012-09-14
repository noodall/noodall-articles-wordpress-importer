require 'noodall/articles/wordpress-importer/blog'
require 'noodall/articles/wordpress-importer/blog_post'

module Noodall
  module Articles
    module WordPressImporter
      class Importer
        def initialize(export_file, article_list)
          @export_file = export_file
          @article_list = article_list
        end

        def run
          parent = article_list

          wordpress_posts = Blog.new(@export_file).posts
          wordpress_posts.each do |post|
            article = Article.new
            article.parent = parent
            article.body = post.content
            article.description = post.excerpt
            article.title = post.title
            article.keywords = post.categories.join(',')

            article.published_at = post.publish_date
            article.published_to = post.publish_date + 10.years

            puts article.title
            puts article.published_at
            puts article.published_to
            puts article.categories

            article.save
          end
        rescue ExportFileMissingError, MissingArticleListError
          $stdout.puts <<-EOS.strip_heredoc

            Export file does not exist or article list is missing

                rake wordpress:import EXPORT_FILE=path/to/file.xml ARTICLE_LIST_ID=<article_list_id> RAILS_ENV=production
          EOS
        end

        private

        def article_list
          Noodall::Node.find!(@article_list)
        rescue MongoMapper::DocumentNotFound
          raise MissingArticleListError
        end
      end
    end
  end
end
