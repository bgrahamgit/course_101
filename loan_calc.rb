require 'yaml'
MESSAGES = YAML.load_file('loan_calc.yml')

def messages(msg)
  MESSAGES[msg]
end

def prompt(msg)
  puts "=> #{msg}"
end

def validate_num(num)
  (num.to_f.to_s == num || num.to_i.to_s == num) && num.to_f > 0
end

def get_number(msg, error_msg)
  input = nil
  loop do
    prompt(msg)
    input = gets.chomp
    return input if validate_num(input)
    prompt(error_msg)
  end
end

prompt(messages('welcome'))

loop do
  loan_amount = get_number(messages('amount_msg'), messages('error_msg')).to_f
  apr = get_number(messages('apr_msg'), messages('error_msg')).to_f / 100
  loan_period = get_number(messages('period_msg'), messages('error_msg')).to_f

  monthly_rate = apr / 12
  loan_period_months = loan_period * 12

  monthly_pmt = loan_amount * (monthly_rate /
                (1 - (1 + monthly_rate)**(-loan_period_months)))

  puts "=> The monthly payment for a #{loan_period} year,
         $#{loan_amount} loan at #{apr * 100}% is $#{monthly_pmt}"

  prompt(messages('continue_msg'))
  continue = gets.chomp
  break unless continue.downcase.start_with?('y')
end

prompt(messages('farewell_msg'))
