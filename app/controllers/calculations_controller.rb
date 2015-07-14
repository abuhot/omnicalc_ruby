class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.strip.length

    @character_count_without_spaces = @text.delete(' ').length

    @word_count = @text.split.count

    @occurrences = @text.downcase.gsub("."," ").split.count(@special_word.downcase)

  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    # c is the monthly interest rate
    c = ((@apr/100)/12).to_f
    n = @years * 12


    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    #Monthly Payment Formula - P = L[c(1 + c)n]/[(1 + c)n - 1]

    @monthly_payment = @principal*(c*(1+c)**n)/((1+c)**n - 1)

    #@monthly_payment = @principal.to_s + " " + c.to_s + " " + n.to_s
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

   # @median = "Replace this string with your answer."

    @sum = @numbers.inject(0) { |result, element| result + element }

    #Determine Median
        #First determine even or odd number in array
         if @count % 2 == 0
            even = true
         end

    if even
        m_pos = (@count/2) - 1
        @median = ((@sorted_numbers[m_pos] + @sorted_numbers[(m_pos + 1)])/2)
        #@median = @sorted_numbers[1]
    else
        m_pos = (@count - 1)/2
        @median = @sorted_numbers[m_pos]
        #@median = @sorted_numbers[1]
    end


    @mean = @sum/@count

    var = 0

    @numbers.each do |i|
       #var = var.to_f + ( ( (i - @mean.to_f) ** 2)/(@count))
       var = var.to_f + ( (i - @mean.to_f) ** 2)
    end

    var = var/@count
    @variance = var.to_f

    #@standard_deviation = @variance.math.sqrt

    @standard_deviation = Math.sqrt(@variance)

    #calculate mode
        #initialize variables
        i = 0
        arrayCount = 0
        last_sorted_number = @minimum
        h = {}
        #First cycle throught the sorted array and build a hash that contains the number of occurrences for each number.  They key will be the number
        @sorted_numbers.each do |v_num|

            arrayCount = arrayCount + 1

           if v_num == last_sorted_number
                i = i + 1
           else
                h["#{last_sorted_number}"] = i
                i = 1

           end

           last_sorted_number = v_num.to_i

           if arrayCount = @count

               h["#{last_sorted_number}"] = i

          end

        end

       max_key = h.values.max
       mode = h.select { |k, v| v == max_key }.keys
       @mode = mode[0].to_f




    #@mode = "Replace this string with your answer."
  end
end
