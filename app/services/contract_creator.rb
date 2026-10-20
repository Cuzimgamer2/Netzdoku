class ContractCreator
  def initialize(customer:, name:)
    @customer = customer
    @name = name
  end

  def create
    Contract.create!(
      customer: @customer,
      name: @name
    )
  end
end
