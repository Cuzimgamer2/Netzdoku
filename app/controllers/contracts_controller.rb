# class ContractsController < ApplicationController
#   def create
#     contract = Contract.create!(customer: current_customer)
#     device = Device.find(params[:device_id])
#     device.update!(contract: contract)
#     puts("#{current_customer} sie haben eine neue benachrichtigung")
#   end
# end