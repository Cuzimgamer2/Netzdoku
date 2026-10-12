class NetworkDevice
  attr_reader :name, :ip_address, :status
  VALID_STATUS = ["running", "stopped", "waiting"]

  
  def initialize(name, ip_address, status)
    @name = name
    @ip_address = ip_address
    update_status!(status)
  end

  def describe
    "Infos: #{@name}, #{@ip_address}, #{@status}"
  end
  def update_status!(new_status)
    if VALID_STATUS.include?(new_status)
      @status = new_status
    else
      puts "not working, error"
    end
  end
end

network = NetworkDevice.new("mikrotik", "1.1.1.1", "running")
puts network.describe