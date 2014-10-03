require_relative 'bank'
require_relative 'developer'
require_relative 'deposit'
require_relative 'loan'
require_relative 'nama'

class Main

end

nama = Nama.instance
aib = Bank.new("aib", "500",6)
yang = Developer.new("yang")

yang.new_deposit(200,aib)

puts aib.cash_deposits
