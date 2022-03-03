require "services/response"

module Services::Base
  def self.included(base)
    base.extend ClassMethods

    base.private_class_method :new
    base.send(:attr_reader, :response)
  end

  module ClassMethods
    def call(**args)
      service = new(**args)
      service.instance_variable_set(:@response, Services::Response.new)

      if ServiceObjectsRails.return_service_response_object
        service.response.body = service.call
        service.response
      else
        service.call
      end
    end
  end
end
