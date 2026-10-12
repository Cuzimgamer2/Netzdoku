require "rails_helper"

RSpec.describe DeviceAssigner do
  it "weist ein Gerät einem Vertrag zu" do
    device = double
    contract = double

    allow(Device).to receive(:find).and_return(device)
    expect(device).to receive(:update!).with(contract: contract)

    DeviceAssigner.new(device_id: 1, contract: contract).call
  end
end