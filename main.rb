require_relative 'bank'
require_relative 'developer'
require_relative 'deposit'
require_relative 'loan'
require_relative 'nama'

class Main

  def menu
    welcomeText = "\nWelcome to Bank, NAMA and Developer System\n"
    puts welcomeText  #=> this will be displayed at the beginning of the app

    puts"===================SAMPLE====================="
    puts self.family_member_to_s_each
    @family_member_list.each {|fm|  test_type_of_family_member(fm)}
    puts"====================SAMPLE END====================\n"

    num = 0
    begin
      puts "1 Show all famliy members(each loop) \n
        2 Show all famliy members(do loop)\n
        3 Show Speding list of a famliy member\n
        4 Show type of a famliy member \n
        5 Save famliy member and spending list to text file \n
        6 Exit\n"
      puts "Enter a number"
      num = gets
      num = num.chomp
      case
      when num == "1"
      puts self.family_member_to_s_each
      when num == "2"
      puts self.family_member_to_s_do
      when num == "3"
      self.search_a_family_member_for_spending_list
      when num == "4"
        self.search_a_family_member_for_type
      when num == "5"
      save_list(self.family_member_and_spending_list_to_s_do)
      when num == "6"
    abort("See you!")
      end
    end until num == "5"

  end

  def sample_output
    #
  end

end

nama = Nama.instance

aib = Bank.new("AIB", "500",6)
boi = Bank.new("BOI", "500",6)
anglo = Bank.new("Anglo", "500",6)
rbs = Bank.new("RBS", "500",6)
ulster = Bank.new("Ulster", "500",6)

bank_list = [aib, boi, anglo, rbs, ulster]

johnny_ronan = Developer.new("Johnny Ronan")
murtagh = Developer.new("Murtagh")
lowry = Developer.new("Lowry")
joe_bloggs = Developer.new("Joe Bloggs")
james_smith = Developer.new("James Smith")

johnny_ronan.new_deposit(200,aib)
johnny_ronan.new_deposit(100,aib)
johnny_ronan.new_loan(100,aib)
johnny_ronan.new_loan(100,aib)
johnny_ronan.new_loan(100,boi)
johnny_ronan.new_loan(100,boi)

johnny_ronan.deposit_amount(bank_list)
johnny_ronan.owes_amount(bank_list)
johnny_ronan.owes_bank(bank_list)
  
puts johnny_ronan.is_developer_solvent?
if johnny_ronan.is_developer_solvent?
  puts "#{johnny_ronan.name} declares bankrupt."
  johnny_ronan.declared_bankrupt(bank_list)
end

puts aib.to_s

aib.deposit_list.each do |d|
  puts d
end