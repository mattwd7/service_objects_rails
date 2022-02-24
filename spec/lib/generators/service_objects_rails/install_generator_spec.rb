require "spec_helper"
require "generators/service_objects_rails/install_generator"

describe ServiceObjectsRails::Generators::InstallGenerator do
  before(:all) { remove_config }
  after(:all) { remove_config }

  it "installs config file properly" do
    described_class.start
    expect(File.file?(config_file)).to be true
  end
end
