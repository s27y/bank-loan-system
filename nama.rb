require 'singleton'

class Nama
  include Singleton

  @@RETURN_RATIO = 0.3
  attr_accessor :balance_sheet, :loan_book

  def initialize
  	@balance_sheet = 0
    @loan_book = Array.new
    #
  end

  def self.RETURN_RATIO
    @@RETURN_RATIO
  end

  # This should only called by bank
  #
  def receive_loans_from_bank(loan, bank)
  	#
    puts "NAMA receives a loan from #{bank.name}"
    @loan_book << loan
  	@balance_sheet += loan.amount* 0.7
  	bank.receive_cash_from_nama_based_on_loan(loan)
  end
end