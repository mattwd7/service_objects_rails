require "rails/generators"

module Services
  module Generators
    class NewGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __dir__)

      argument :service_name, type: :string
      argument :service_args, type: :array, default: []

      desc "Creates a new Service Object and corresponding spec file"

      def create_new_service
        template(
          "new_service.erb",
          "#{Rails.root}/app/namespaces/services/#{service_filepath}.rb"
        )
      end

      def create_new_service_spec
        template(
          "new_service_spec.erb",
          "#{Rails.root}/spec/namespaces/services/#{service_filepath}_spec.rb"
        )
      end

      private

      def service_filepath
        service_name.gsub(/::/, "/")
          .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .tr("-", "_")
          .downcase
      end
    end
  end
end
