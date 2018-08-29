

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'es'

def prompt(message)
  puts "=> #{message}"
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def number?(num)
  integer?(num) || float?(num)
end

def operation_to_msg(op)
  result =  case op
            when '1'
              'Adding'
            when '2'
              'Subtracting'
            when '3'
              'Multiplying'
            else
              'Dividing'
            end

  result
end

def messages(message,  lang='en')
  MESSAGES[lang][message]
end

prompt(messages('welcome', LANGUAGE))

name = ''

loop do
  name = gets.chomp
  if name.empty?
    prompt(messages('valid_name', LANGUAGE))
  else
    break
  end
end

prompt("Hi #{name}!")

loop do
  number1 = ''
  loop do
    prompt(messages('number1_input', LANGUAGE))
    number1 = gets.chomp

    if number?(number1)
      break
    else
      prompt(messages('valid_num', LANGUAGE))
    end
  end

  number2 = ''

  loop do
    prompt(messages('number2_input', LANGUAGE))
    number2 = gets.chomp

    if number?(number2)
      break
    else
      prompt(messages('valid_num', LANGUAGE))
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG
  
  prompt(operator_prompt)

  operator = ''

  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages('valid_op', LANGUAGE))
    end
  end

  prompt("#{operation_to_msg(operator)} the two numbers...")

  result =  case operator
            when '1'
              number1.to_i + number2.to_i
            when '2'
              number1.to_i - number2.to_i
            when '3'
              number1.to_i * number2.to_i
            else
              number1.to_f / number2.to_f
            end

  prompt("The result is #{result}")

  prompt(messages('continue', LANGUAGE))
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end 

prompt(messages('farewell', LANGUAGE))
