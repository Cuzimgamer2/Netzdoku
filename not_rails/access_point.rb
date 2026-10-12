require_relative 'network_device'
require_relative 'pingable'
class AccessPoint < NetworkDevice
  attr_reader :range
  include Pingable
  def initialize(name, ip_address, status, range)
    super(name, ip_address, status)
    @range = range
  end

  def describe
    "Infos switch: #{name}, #{ip_address}, #{status}, #{range}"
  end
end


access_point = AccessPoint.new("mikrotik", "1.1.1.1", "running", "30m")
puts access_point.describe
puts access_point.ping
