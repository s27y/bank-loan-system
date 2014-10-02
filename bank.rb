class Bank
  attr_accessor :name, :no_of_employees, :cash_deposits, :amount_of_loans, \
                :losses, :in_nama, :solvent, :loan_book, :ratio_of_basil_rules
  def initialize(name, no_of_employees,)
  	#
  end

  def move_loans_to_nama(aLoan)
    #
    
  end

  # Return a boolean which depends amount of loans, ratio and cash deposits
  #
  def is_solvent?
  	#
  	@amount_of_loans < (@cash_deposits * @ratio_of_basil_rules - @losses)
  end

  def make_solvent
  	#
  end

end
