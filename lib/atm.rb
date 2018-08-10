class Atm
  attr_accessor :info, :accounts, :banknotes

  def initialize(info)
    @accounts = info["accounts"]
    @banknotes = info["banknotes"]
    @balance = banknotes
    @atm_balance = @balance.map{|k,v| k*v}.inject(:+)
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
    case user_action
      when 1
        account_balance
      when 2
        withdraw
    end
  end

  def account_balance
    puts "Your Current Balance is ₴#{@accounts[@account_number]["balance"]}."
  end

  def withdraw
    puts 'Enter Amount You Wish to Withdraw:'
    user_amount = gets.chomp.to_i
    
    if insufficient_funds_in_account?(user_amount)
      puts 'ERROR: INSUFFICIENT FUNDS!! PLEASE ENTER A DIFFERENT AMOUNT:'
    elsif insufficient_funds_in_atm?(user_amount)
      puts 'ERROR: THE MAXIMUM AMOUNT AVAILABLE IN THIS ATM IS ₴337. PLEASE ENTER A DIFFERENT AMOUNT:'
    else
      perform_transaction(user_amount)
    end
  end

  private

  def  insufficient_funds_in_account?(user_amount)
    user_amount > @accounts[@account_number]["balance"]
  end

  def  insufficient_funds_in_atm?(user_amount)
    @atm_balance < user_amount
  end

  def fetch_notes(user_amount)
    withdrawn_notes = {}
    @withdrawn_amount = 0

    notes = @balance.keys.sort.reverse 
    notes.each do |note|
      max_notes = (user_amount - @withdrawn_amount) / note
      actual_notes = [@balance[note], max_notes].min
      
      if actual_notes > 0
        @withdrawn_amount += actual_notes * note
        withdrawn_notes[note] = actual_notes
      end
    end

    withdrawn_notes
  end

  def  perform_transaction(user_amount)
    user_withdraw = fetch_notes(user_amount).map{|k,v| k*v}.inject(:+)
    @atm_balance -= user_withdraw

    if @withdrawn_amount < user_amount
      puts "ERROR: THE AMOUNT YOU REQUESTED CANNOT BE COMPOSED FROM BILLS AVAILABLE IN THIS ATM. PLEASE ENTER A DIFFERENT AMOUNT:"
    else
      @accounts[@account_number]["balance"] -= user_withdraw
      puts "Your New Balance is #{@accounts[@account_number]["balance"]}" 
    end 
  end

end