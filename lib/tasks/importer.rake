require 'noodall/articles/wordpress-importer/importer'

namespace :wordpress do
  desc "Import a WordPress blog export file into Noodall Articles"
  task :import  => :environment do
    Noodall::Articles::WordPressImporter::Importer.import
  end
end

