require "spec_helper"
require "services/response"

RSpec.describe Services::Response do
  subject(:service_response) { described_class.new }

  describe "#body" do
    it "returns nil by default" do
      expect(service_response.body).to be_nil
    end
  end

  describe "#errors" do
    it "returns an empty array by default" do
      expect(service_response.errors).to eq([])
    end
  end

  describe "#success?" do
    context "without errors" do
      it "returns true" do
        expect(service_response.success?).to eq(true)
      end
    end

    context "with errors" do
      before { service_response.add_errors("Some error") }

      it "returns false" do
        expect(service_response.success?).to eq(false)
      end
    end
  end

  describe "#add_errors" do
    it "adds multiple strings of errors to the errors array" do
      expect { service_response.add_errors("error message 1", "error message 2") }
        .to change(service_response, :errors)
        .from([])
        .to(["error message 1", "error message 2"])
    end
  end
end
