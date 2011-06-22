1. Print the string "Hello, world"
				
        puts 'Hello, world'
				
2. For the string "Hello, Ruby." find the index of the word "Ruby."

        'Hello, Ruby.'.index 'Ruby.'
				
3. Print your name ten times.

        10.times { puts "Dirk" }
				
4. Print the string "This is sentence number 1," where the number one changes from 1 to 10.

        10.times { |t|  puts "This is sentence number  #{t+1}" }
        
5. Write a program that picks a random number. Let a player guess that number, telling the player wether the guess is too low or too high.

        numb = rand(10)
        guess = nil

        while guess != numb 
            puts "Guess a number from zero to ten"
            guess = gets.to_i

            case 
            when guess < numb
                puts "#{guess} is to low"
            when guess > numb
                puts "#{guess} is to high"
            when guess == numb
                puts "Correct!"
            end

        end