require_relative 'bank'
require_relative 'developer'
require_relative 'deposit'
require_relative 'loan'
require_relative 'nama'
require_relative 'io'
class Main
  attr_accessor :bank_list, :developer_list, :nama,\
  :johnny_ronan, :murtagh, :lowry, :joe_bloggs, :james_smith, \
  :aib, :boi, :anglo, :rbs, :ulster


  def initialize
    #
    @nama = Nama.instance
    @developer_list = Array.new
    @bank_list = Array.new
    self.seed_data
    
  end

  def run_app
    
  end


  def seed_data
    @aib = Bank.new("AIB", "500",6)
    @boi = Bank.new("BOI", "500",6)
    @anglo = Bank.new("Anglo", "500",6)
    @rbs = Bank.new("RBS", "500",6)
    @ulster = Bank.new("Ulster", "500",6)

    @bank_list = [aib, boi, anglo, rbs, ulster]

    @johnny_ronan = Developer.new("Johnny Ronan")
    @murtagh = Developer.new("Murtagh")
    @lowry = Developer.new("Lowry")
    @joe_bloggs = Developer.new("Joe Bloggs")
    @james_smith = Developer.new("James Smith")

    @developer_list = [johnny_ronan, murtagh, lowry, joe_bloggs, james_smith]
  end

  def load_deposit_and_loans
    @johnny_ronan.new_deposit(200,@aib)
    @johnny_ronan.new_deposit(100,@aib)
    @johnny_ronan.new_loan(100,@aib)
    @johnny_ronan.new_loan(100,@aib)
    @johnny_ronan.new_loan(100,@boi)
    @johnny_ronan.new_loan(100,@boi)

    @murtagh.new_deposit(1200,@anglo)
    @murtagh.new_deposit(500,@rbs)
    @murtagh.new_loan(1000,@anglo)
    @murtagh.new_loan(2000,@anglo)
    @murtagh.new_loan(100,@rbs)
    @murtagh.new_loan(100,@rbs)

    @lowry.new_deposit(200,@aib)
    @lowry.new_deposit(100,@aib)
    @lowry.new_loan(100,@aib)
    @lowry.new_loan(100,@aib)
    @lowry.new_loan(100,@boi)
    @lowry.new_loan(100,@boi)

    @joe_bloggs.new_deposit(200,@aib)
    @joe_bloggs.new_deposit(300,@rbs)
    @joe_bloggs.new_loan(100,@aib)
    @joe_bloggs.new_loan(100,@aib)
    @joe_bloggs.new_loan(100,@rbs)
    @joe_bloggs.new_loan(100,@rbs)

    @james_smith.new_deposit(200,@aib)
    @james_smith.new_deposit(300,@rbs)
    @james_smith.new_loan(100,@aib)
    @james_smith.new_loan(100,@aib)
    @james_smith.new_loan(100,@rbs)
    @james_smith.new_loan(100,@rbs)
  end

  def print_developer_net_worth
    @developer_list.each do |d|
      puts "#{d.name} Net worth: "+ d.net_worth.to_s
    end
  end

  def print_developer_depoist_list
    #
    @developer_list.each do |d|
      puts d.deposit_amount(@bank_list)
    end
  end

  def print_developer_loan_list
    #
    @developer_list.each do |d|
      puts d.owes_amount(@bank_list)
    end
  end

  def print_bank_list_detail
    puts "Name\tNo.Empl\tDeposits\tLoans\tLosses\tIn NAMA"

    @bank_list.each do |b|
    puts b.to_s
    end
  end


  def check_solvenct
    @developer_list.each do |d|
      if d.is_developer_solvent?
        puts "#{d.name} declares bankrupt."
        d.declared_bankrupt(bank_list)
      end
    end
  end

  def make_new_deposit 
    the_bank  = nil

    loop do 
      puts "Enter a bank name:"
      bank_name = gets

      @bank_list.each do |b|
      #
        if b.name.downcase == bank_name.chomp.downcase
          the_bank = b
          break
        end
      end
      break if the_bank != nil
    end 
    amount=0
    number_input_flag =false
    loop do 
      puts "Enter amount you want to deposit:"
      amount = gets

      begin  
      amount = Integer(amount.chomp)
      number_input_flag = true
      rescue ArgumentError
        number_input_flag = false
      end  


      break if number_input_flag != false
    end
    puts "Before deposit:"
    puts joe_bloggs.to_s
    @joe_bloggs.new_deposit(amount,the_bank)
    puts "After deposit"
    puts "Name\tNetworth\tDeposits\tLoans\tBankrupt"
    puts @joe_bloggs.to_s

  end

  def make_new_loan
        the_bank  = nil

    loop do 
      puts "Enter a bank name:"
      bank_name = gets

      @bank_list.each do |b|
      #
        if b.name.downcase == bank_name.chomp.downcase
          the_bank = b
          break
        end
      end
      break if the_bank != nil
    end 
    amount=0
    number_input_flag =false
    loop do 
      puts "Enter amount you want to loan:"
      amount = gets

      begin  
      amount = Integer(amount.chomp)
      number_input_flag = true
      rescue ArgumentError
        number_input_flag = false
      end  


      break if number_input_flag != false
    end
    puts "Before loan:"
    puts joe_bloggs.to_s
    @joe_bloggs.new_loan(amount,the_bank)
    puts "After loan"
    puts "Name\tNetworth\tDeposits\tLoans\tBankrupt"
    puts @joe_bloggs.to_s
  end



  def menu
    welcomeText = "\nWelcome to Bank, NAMA and Developer System\n"
    puts welcomeText  #=> this will be displayed at the beginning of the app

    num = 0
    begin
      puts "1 Make a deposit as Joe Bloggs \n
        2 Apply a loan as Joe Bloggs\n
        3 Check bank details\n
        4 Declare Bankrupt and see the knock on effect \n
        5 Check Joe Bloggs' Bank Statement and print to file \n
        6 Exit\n"
      puts "Enter a number"
      num = gets
      num = num.chomp
      case
      when num == "1"
        self.make_new_deposit
      when num == "2"
        self.make_new_loan
      when num == "3"
        self.print_bank_list_detail
      when num == "4"
        joe_bloggs.declared_bankrupt(@bank_list)
      when num == "5"
        save_list(joe_bloggs.deposit_amount(@bank_list),"deposits_statment.txt")
        save_list(joe_bloggs.owes_amount(@bank_list),"loans_statement.txt")
      when num == "6"
    abort("See you!")
      end
    end until num == "6"

  end

  def sample_output
    #
  end

end

puts"===================SAMPLE====================="
main = Main.new
puts "\nInitial Bank Details"
main.print_bank_list_detail
puts "\nInitial Developer Details"
main.print_developer_net_worth

main.load_deposit_and_loans
puts "\nAfter Load Deposits and Loans"
main.print_bank_list_detail
main.print_developer_net_worth

puts "\n Call check solvent"
main.check_solvenct

puts "\nAfter check solvent"
main.print_bank_list_detail
puts"====================SAMPLE END====================\n"
main.menu
