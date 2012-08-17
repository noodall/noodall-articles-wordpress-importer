module Noodall
  module Articles
    module WordPressImporter
      class Railtie < Rails::Railtie
        rake_tasks do
          load "tasks/importer.rake"
        end
      end
    end
  end
end
