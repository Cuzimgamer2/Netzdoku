class DeviceAssigner
  def initialize(device_id:, contract:)
    @device_id = device_id
    @contract = contract
  end

  def call
    device = Device.find(@device_id)
    device.update!(contract: @contract)
  end
end