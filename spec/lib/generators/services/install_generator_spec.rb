require "spec_helper"
require "generators/services/install_generator"

describe Services::Generators::InstallGenerator do
  before { remove_files_and_directories("#{Rails.root}/config/services.rb") }
  after { remove_files_and_directories("#{Rails.root}/config/services.rb") }

  it "installs config file properly" do
    described_class.start
    expect(File.file?("#{Rails.root}/config/services.rb")).to eq(true)
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
