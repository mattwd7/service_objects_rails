require "spec_helper"
require "generators/service_objects_rails/install_generator"

describe ServiceObjectsRails::Generators::InstallGenerator do
  GENERATED_FILES = [
    "#{Rails.root}/config/service_objects_rails.rb"
  ]
  GENERATED_DIRECTORIES = [
    "#{Rails.root}/app/services",
    "#{Rails.root}/spec/services",
  ]

  before { remove_files_and_directories(GENERATED_FILES + GENERATED_DIRECTORIES) }
  after { remove_files_and_directories(GENERATED_FILES + GENERATED_DIRECTORIES) }

  it "installs config file properly" do
    described_class.start
    expect(File.file?("#{Rails.root}/config/service_objects_rails.rb")).to eq(true)
  end

  it "creates an app/services directory" do
    described_class.start
    expect(File.directory?("#{Rails.root}/app/services")).to eq(true)
  end

  it "creates a spec/services directory" do
    described_class.start
    expect(File.directory?("#{Rails.root}/spec/services")).to eq(true)
  end
end
