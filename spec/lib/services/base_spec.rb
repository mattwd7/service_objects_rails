require "spec_helper"
require "services/base"

RSpec.describe Services::Base do
  subject(:service) do
    Class.new do
      include Services::Base

      def initialize(value_1:, value_2:)
        @value_1 = value_1
        @value_2 = value_2
      end

      def call
        validate_input_types
        return if response.errors.any?

        value_1 * value_2
      end

      private

      attr_reader :value_1, :value_2

      def validate_input_types
        return if [value_1, value_2].all? { |val| val.is_a?(Integer) }

        response.add_errors("Values must be numbers")
      end
    end
  end

  it "cannot be publicly instantiated" do
    expect { service.new(value_1: 4, value_2: 3) }
      .to raise_error(NoMethodError)
  end

  it "returns a Service::Response" do
    service_response = service.call(value_1: 4, value_2: 3)
    expect(service_response).to match(an_instance_of(Services::Response))
  end

  it "puts the return value from #call in the Service::Response#body" do
    service_response = service.call(value_1: 4, value_2: 3)
    expect(service_response.body).to eq(12)
  end

  context "with service that does not name arguments" do
    before do
      service.class_eval do
        def initialize(value_1, value_2)
          @value_1 = value_1
          @value_2 = value_2
        end
      end
    end

    it "raises an error" do
      expect { service.call(3, 4) }.to raise_error(ArgumentError)
    end
  end

  context "with errors added upon service#call" do
    it "makes error messages accessible in the returned response object" do
      service_response = service.call(value_1: 4, value_2: "hey")
      expect(service_response.body).to eq(nil)
      expect(service_response.errors).to eq(["Values must be numbers"])
    end
  end

  context "with gem config return_service_response_object=false" do
    before do
      allow(ServiceObjectsRails).to receive(:return_service_response_object).and_return(false)
    end

    it "returns the return value from #call instead of a Service::Response" do
      expect(service.call(value_1: 4, value_2: 3)).to eq(12)
    end
  end
end
