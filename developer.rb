
class Developer
  attr_accessor :name, :net_worth, :deposit_list, :loan_list, :banks_loaned, :bankrupt  

  def initialize(name)
  	@name = name
  	@net_worth = 0
  	@loan_list = Array.new
  	@deposit_list = Array.new
    #
  end

  def is_developer_solvent?
  	#
    net_worth < 0 
  end

  def new_deposit(amount, bank)
  	#
    deposit = Deposit.new(amount, @name)
    bank.add_cash_deposit(deposit)
  end

  def new_loan(amount, bank)
  	#
    loan = Loan.new(amount, @name)
    bank.add_to_loan_book(deposit)
  end

  def owes_amount
  	#
  end

  def owes_bank
  	#
  end

end