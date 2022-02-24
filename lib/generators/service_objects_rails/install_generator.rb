require "rails/generators"

module ServiceObjectsRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __dir__)

      desc "Creates the file structure for ServiceObjectsRails, " \
        "generates a config files, and generates the ServiceBase module."

      def copy_config
        template "service_objects_rails_config.rb", "#{Rails.root}/config/service_objects_rails.rb"
        # template "service_base.rb", "#{Rails.root}/app/services/service_base.rb"
      end
    end
  end
end
