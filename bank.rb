class Bank
  attr_accessor :name, :no_of_employees, :cash_deposits, :amount_of_loans, \
                :losses, :in_nama, :solvent, :loan_book, :ratio_of_basil_rules, \
                :nama, :deposit_list

  def initialize(name, no_of_employees,ratio_of_basil_rules)
  	#
  	@name, @no_of_employees, @ratio_of_basil_rules = name, no_of_employees, @ratio_of_basil_rules
  	@cash_deposits, @amount_of_loans, @in_nama, @solvent = 0, 0, 0, false
  	@nama = Nama.instance
  	@deposit_list = Array.new
  	@loan_book = Array.new
    @losses = 0
  end

  def to_s
    #
    "#{@name}\t#{@no_of_employees}\t#{@cash_deposits}\t\t#{@amount_of_loans}\t#{@losses}\t#{@in_nama} "
  end

  def add_cash_deposit(deposit)
  	#
  	@cash_deposits += deposit.amount
  	@deposit_list << deposit
  end

  def add_to_loan_book(loan)
  	#
  	@amount_of_loans += loan.amount
  	@loan_book << loan
  end

  def remove_loan(loan)
  	#
  	@amount_of_loans -= loan.amount

  	@loan_book.each do |l|
  	  # TODO need consider if we have two loan with same amount and same name
  	  if l.amount == loan.amount && l.name == loan.name
        #
        loan_book.delete(l)
      end
    end
  end

  def move_loans_to_nama(loan)
    puts "Move loan to nama " + loan.to_s
  	# wrap in a transaction, TODO test it works or not
  	#Bank.transaction do
  	  # This is what bank should do	
      # Remove loan, add in_nama
      self.remove_loan(loan)
      @in_nama += loan.amount
      # Add losses, at this time loss will be 100%,
      # Return percentage is determined by NAMA and NAMA will send the money
      @losses += loan.amount

      # TODO what should NAMA do?
      # call NAMA function, let NAMA get the loan
      nama.receive_loans_from_bank(loan,self)
  	#end
  end

  # Bank can not add cash itself, this method should be called by NAMA
  # after NAMA receive a loan from bank
  #
  def receive_cash_from_nama_based_on_loan(loan)
  	#
    puts "#{@name} receves cash #{loan.amount*Nama.RETURN_RATIO} from NAMA"
  	@losses -= loan.amount * Nama.RETURN_RATIO
    deposit = Deposit.new(loan.amount*Nama.RETURN_RATIO, "NAMA","NAMA")
    self.add_cash_deposit(deposit)
  end

  # Return a boolean which depends on amount of loans, ratio and cash deposits
  #
  def is_solvent?
  	#
  	@amount_of_loans < (@cash_deposits * @ratio_of_basil_rules - @losses)
  end

  # This method will determine which loan or whose loan need be transfered to NAMA
  #
  def make_solvent(loan)
  	self.move_loans_to_nama(loan)
  end

  def find_deposit_by_name(name)
    result = Array.new
    for deposit in deposit_list
      #

      if deposit.name.downcase == name.downcase
        #
        result << deposit
      end
    end
    result
end

def find_loan_by_name(name)
    result = Array.new
    for loan in loan_book
      #
      if loan.name.downcase == name.downcase
        #
        result << loan
      end
    end
    result
  end
end
