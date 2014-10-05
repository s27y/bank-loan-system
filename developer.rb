
class Developer
  attr_accessor :name, :net_worth, :banks_loaned, :bankrupt  

  def initialize(name)
    @name = name
    @net_worth = 0
    @loan_list = Array.new
    @deposit_list = Array.new
    #
  end

  def is_developer_solvent?
    #
    if net_worth < 0
      #
    end
    net_worth < 0
  end

  def new_deposit(amount, bank)
    #
    deposit = Deposit.new(amount, @name, bank.name)
    bank.add_cash_deposit(deposit)
    @net_worth += amount
  end

  def new_loan(amount, bank)
    #
    loan = Loan.new(amount, @name, bank.name)
    bank.add_to_loan_book(loan)
    @net_worth -= amount
  end

  def deposit_amount(bank_list)
    puts "========================"
    puts "Deposit"
    over_all_total = 0
    for bank in bank_list
      #
      bank_total = 0
      puts bank.name
      bank.find_deposit_by_name(@name).each do |deposit|
        over_all_total += deposit.amount
        bank_total += deposit.amount
        puts deposit.to_s
      end
      puts "Total\t"+bank_total.to_s
    end
    puts "Over all Total\t" + over_all_total.to_s
    puts "========================"

  end

  def owes_amount(bank_list)
    puts "========================"
    puts "Loan"
    over_all_total = 0
    for bank in bank_list
      #
      bank_total = 0
      bank_output = "=="+bank.name + "==" + "\n"
      bank.find_loan_by_name(@name).each do |loan|
        over_all_total += loan.amount
        bank_total += loan.amount
        bank_output << loan.to_s  << "\n"
      end
      if bank_total != 0
        puts bank_output+"---------------------\nTotal\t\t"+bank_total.to_s
      end
    end
    puts "Over all Total\t" + over_all_total.to_s
    puts "========================"
  end

  def owes_bank(bank_list)
    for bank in bank_list
      count = 0
      bank.find_loan_by_name(@name).each do |loan|
        count +=1
      end
      if count != 0
        puts count.to_s + " loan from " + bank.name
      end
    end
  end

  def declared_bankrupt(bank_list)
    @bankrupt = true

    # tell all bank he has loan with
    for bank in bank_list
      bank.find_loan_by_name(@name).each do |loan|
        bank.move_loans_to_nama(loan)
      end
    end
  end

end