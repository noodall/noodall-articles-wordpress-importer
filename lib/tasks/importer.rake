require 'noodall/articles/wordpress-importer/importer'

namespace :wordpress do
  desc "Import a WordPress blog export file into Noodall Articles"
  task :import  => :environment do
    Noodall::Articles::WordPressImporter::Importer.new(ENV['EXPORT_FILE'], ENV['ARTICLE_LIST_ID']).run
  end
end

