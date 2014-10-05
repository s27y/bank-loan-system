require_relative 'bank'
require_relative 'developer'
require_relative 'deposit'
require_relative 'loan'
require_relative 'nama'

class Main

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


puts aib.cash_deposits

johnny_ronan.deposit_amount(bank_list)
johnny_ronan.owes_amount(bank_list)
johnny_ronan.owes_amount(bank_list)
johnny_ronan.owes_bank(bank_list)

puts johnny_ronan.is_developer_solvent?
if johnny_ronan.is_developer_solvent?
	puts "#{johnny_ronan.name} declares bankrupt."
	johnny_ronan.declared_bankrupt(bank_list)
end


puts aib.losses.to_s + "  " + aib.in_nama.to_s