describe ServiceObjectsRails do
  let(:fake_class) { class_double(described_class) }

  it "accepts config options" do
    described_class.config do |c|
      expect(c).to eq(described_class)
    end
  end

  it "assigns default values to config options" do
    expect(described_class.return_service_response_object)
      .to eq(true)
  end

  it "allows for reassignment of config option values" do
    expect(fake_class).to receive(:return_service_response_object=).with(false)
    fake_class.return_service_response_object = false
  end
end
