module Services
  class << self
    attr_writer :return_service_response_object

    def config
      yield self
    end

    def return_service_response_object
      @return_service_response_object.nil? ? true : @return_service_response_object
    end
  end
end
