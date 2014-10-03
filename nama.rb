require 'singleton'

class Nama
  include Singleton

  @@RETURN_RATIO= 0.3
  attr_accessor :balance_sheet, :loan_book

  def initialize
  	@balance_sheet = 0
    #
  end

  # This should only called by bank
  #
  def receive_loans_from_bank(loan, bank)
  	#
  	@balance_sheet -= loan.amount
  	bank.receive_cash_from_nama_based_on_loan(loan)
  end
end