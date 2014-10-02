class Bank
  attr_accessor :name, :no_of_employees, :cash_deposits, :amount_of_loans, \
                :losses, :in_nama, :solvent, :loan_book, :ratio_of_basil_rules \
                :nama

  def initialize(name, no_of_employees,ratio_of_basil_rules)
  	#
  	@name, @no_of_employees, @ratio_of_basil_rules = name, no_of_employees, @ratio_of_basil_rules
  	@cash_deposits, @amount_of_loans, @in_nama, @solvent = 0, 0, 0, false
  	@nama = Nama.instance
  end

  def move_loans_to_nama(loan)
  	Bank.transaction do
  	  # This is what bank should do	
      # Remove loan, add in_nama
      @in_nama += loan.amount
      @amount_of_loans -= loan.amount
      # Add losses
      @losses += loan.amount * (1 - Nama.Return_ratio)

      # TODO what should NAMA do?
      nama.receive_loans_from_bank(loan)
  	end
  end

  # Get Nama. TODO where should we pass in a instance of nama?
  #
  def nama
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
b = Bank.new("1",2,3)