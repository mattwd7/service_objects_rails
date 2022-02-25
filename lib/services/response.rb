module Services
  class Response
    attr_accessor :body
    attr_reader :errors

    def initialize
      @body = nil
      @errors = []
    end

    def add_errors(*errors)
      @errors.concat(Array(errors))
    end

    def success?
      errors.empty?
    end
  end
end
