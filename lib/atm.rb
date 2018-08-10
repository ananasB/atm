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
      print_commands
    else
      puts "ERROR: ACCOUNT NUMBER AND PASSWORD DON'T MATCH"
    end
  end

  def print_commands
    commands = [
      [1, 'Display Balance'], [2, 'Withdraw']
    ]
    puts 'Please Choose From the Following Options:'
    commands.each { |key, value| puts "#{key}.  #{value}." }

    user_action = gets.chomp.to_i
    process_command(user_action)
  end

  def process_command(user_action)
    case
      when 1
        account_balance
      when 2
        withdraw
    end
  end

  def account_balance
  end

  def withdraw
  end
end