require "spec_helper"
require "generators/services/new_generator"

describe Services::Generators::NewGenerator do
  let(:service_name) { "MyNewService" }
  let(:service_path) { "#{Rails.root}/app/namespaces/services/my_new_service.rb" }
  let(:service_spec_path) { "#{Rails.root}/spec/namespaces/services/my_new_service_spec.rb" }

  before { remove_files_and_directories }
  after { remove_files_and_directories }

  it "creates a new service object in the app/namespaces/services directory" do
    described_class.start([service_name])

    file_contents = File.read(service_path)
    expect(file_contents).to include("class MyNewService")
    expect(file_contents).to include("include Services::Base")
  end

  it "creates a new service object in the app/namespaces/services directory" do
    described_class.start([service_name])

    file_contents = File.read(service_spec_path)
    expect(file_contents).to include("RSpec.describe Services::MyNewService do")
  end

  it "creates a service response subject that calls the service" do
    described_class.start([service_name, "user_id", "friend_id"])

    file_contents = File.read(service_spec_path)
    expect(file_contents).to include("subject(:service_response)")
    expect(file_contents).to include("described_class.call")
  end

  context "with service arguments" do
    it "creates a service object that accepts provided service arguments" do
      described_class.start([service_name, "user_id", "friend_id"])

      file_contents = File.read(service_path)
      expect(file_contents).to include("def initialize(user_id:, friend_id:)")
      expect(file_contents).to include("@user_id = user_id")
      expect(file_contents).to include("@friend_id = friend_id")
    end

    it "makes service arguments privately readable" do
      described_class.start([service_name, "user_id", "friend_id"])

      file_contents = File.read(service_path)
      expect(file_contents).to include("attr_reader :user_id, :friend_id")
    end

    it "creates a spec with service response subject that calls the service with arguments" do
      described_class.start([service_name, "user_id", "friend_id"])

      file_contents = File.read(service_spec_path)
      expect(file_contents).to include("described_class.call(\n")
      expect(file_contents).to include("user_id: user_id,\n")
      expect(file_contents).to include("friend_id: friend_id\n")
    end

    it "creates a spec with `let`s defined for each argument" do
      described_class.start([service_name, "user_id", "friend_id"])

      file_contents = File.read(service_spec_path)
      expect(file_contents).to include("let(:user_id) { nil }")
      expect(file_contents).to include("let(:friend_id) { nil }")
    end
  end

  context "with namespacing" do
    let(:service_name) { "Users::MyNewService" }
    let(:service_path) { "#{Rails.root}/app/namespaces/services/users/my_new_service.rb" }

    it "creates a new service object within an appropriate file structure" do
      described_class.start([service_name])

      file_contents = File.read(service_path)
      expect(file_contents).to include("class Users::MyNewService")
    end
  end
end
