
# Build a loan payment calculator
# Take 3 user inputs:
#   -define function for displaying of messages
#   -define function that takes a message and returns a float
#   -define a function that validates the inputs as floats
#   -assign the values to three variables
#     -loan amount
#     -APR
#     -loan period

# calculate monthly rate
#   -assign to new variable
# calculate loan period in months
#   -assign to new variable
# calculate monthly mortgage payment amount
#   -assign to payment variable
# display monthly payment to user
# Ask if user would like to repeat

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

def get_number(msg)
  input = nil
  loop do
    prompt(msg)
    input = gets.chomp
    return input if validate_num(input)
    prompt(MESSAGES['error_msg'])
  end
end

prompt(messages('welcome'))

loop do
  loan_amount = get_number(messages('amount_msg')).to_f
  apr = get_number(messages('apr_msg')).to_f / 100
  loan_period = get_number(messages('period_msg')).to_f

  monthly_rate = apr / 12
  loan_period_months = loan_period * 12

  monthly_pmt = loan_amount * (monthly_rate /
                (1 - (1 + monthly_rate)**-loan_period_months))

  puts "=> The monthly payment for a #{loan_period} year,
         $#{loan_amount} loan at #{apr * 100}% is $#{monthly_pmt}"

  prompt(messages('continue_msg'))
  continue = gets.chomp
  break unless continue.downcase.start_with?('y')
end

prompt(messages('farewell_msg'))
