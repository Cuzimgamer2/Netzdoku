class ContractCreator
  def create
    contract = Contract.create!(customer: current_customer)
  end
end