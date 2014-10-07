class Loan
  attr_accessor :amount, :name, :bank

  def initialize(amount, name, bank)
  	@amount, @name, @bank = amount, name, bank
  end

  def to_s
  	@name + "\t" + @amount.to_s
  end
end