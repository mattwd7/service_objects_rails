require "rails/generators"

module Services
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __dir__)

      desc "Creates the file structure for Service objects, " \
        "generates a config files, and generates the ServiceBase module."

      def copy_config
        template(
          "service_objects_rails_config.rb",
          "#{Rails.root}/config/service_objects_rails.rb"
        )
      end

      def setup_file_structure
        empty_directory("#{Rails.root}/app/namespaces/services")
        empty_directory("#{Rails.root}/spec/namespaces/services")
      end
    end
  end
end
