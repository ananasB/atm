class Atm
  attr_accessor :info, :accounts

  def initialize(info)
    @accounts = info["accounts"]
    @banknotes = info["banknotes"]
  end

  def start
    puts 'Please Enter Your Account Number:'
    @account_number = gets.chomp.to_i
    puts 'Enter Your Password:'
    @account_pass = gets.chomp
    
    if @accounts[@account_number]['password'] == @account_pass
      puts "Hello, #{@accounts[@account_number]['name']}!"
    else
      puts "ERROR: ACCOUNT NUMBER AND PASSWORD DON'T MATCH"
    end
  end
end