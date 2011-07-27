## Do: ##

1. A fibonacci sequence starts with two 1s. Each subsequent number is the sum of the two numbers that came before: 1, 1, 2, 3, 5, 8, 13, 21 and so on. Write a program to find the nth Fibonacci number. fib(1) is 1, and fib(4) is 3. As a bonus, solve the problem with recursion and loops.

    Answer with loops:
    
        fib := method(n,
        	seq := list(1, 1)
        	for(i, 3, n, seq append(seq at(-2) + seq at(-1)))
        	return seq at (-1)
        )

        for(i, 1, 8, i print; ": " print; fib(i) println)

    Answer with recursion:
    
        fib := method(n,
        	if(n < 3, 1, fib(n - 1) + fib(n - 2))
        )

        for(i, 1, 8, i print; ": " print; fib(i) println)
    
2. How would you change / to return 0 if the denominator is zero?

        Number divideBy := Number getSlot("/")

        Number / := method(i,
        	if(i == 0, 0, call target divideBy(i))
        )

        for(i, -3, 3, "5 / " print; i print; " = " print;  (5 / i) println)
        
3. Write a program to add up all the numbers in a two dimensional array.

        array := list(list(1, 2, 3), list(2, 3), list(3))

        t := 0
        for(i, 0, array size - 1,
        	t = t + array at(i) sum
        )

        t println
        
4. Add a slot called myAverage to a list that computes the average of all the numbers in a list. 

        List myAverage := method(
        	self sum / self size
        )
    
    What happens if there are no numbers in that list?
    
        Exception: argument 0 to method '+' must be a Number, not a 'Sequence'
          ---------
          +                                   [unlabeled] 0
          List reduce                          A3_List.io 3
          List sum                             fib.io 2
          List myAverage                       fib.io 7
          CLI doFile                           Z_CLI.io 140
          CLI run                              IoState_runCLI() 1
    
    Bonus: Raise an Io exception if any item in the list is not a number.
    
        List myAverage := method(
        	if( self detect(v, v type != "Number"),
        		Exception raise ("Non numeric values found in list"),
        		self sum / self size
        	)
        )
        
5. Write a prototype for a two-dimensional list. The dim(x, y) method should allocate a list of y lists that are x elements long. set(x, y, value) should set a value, and get(x, y) should return that value.

        Matrix := List clone

        Matrix init := method(
        	for(i, 1, self size, 
        		self atPut(i-1, self at(i-1) clone)
        	)
        )

        Matrix dim := method(x, y,
        	for(i, 1, y,
        		xl := list()
        		for(i, 1, x,
        			xl append(nil)
        		)
        		self append(xl)
        	)
        )

        Matrix set := method(x, y, v,
        	self at(y-1) atPut(x-1, v)
        )

        Matrix get := method(x, y,
        	self at(y-1) at(x-1)
        )
        
6. Write a transpose method so that (new_matrix get(y, x) == matrix get(x, y)) on the original list.

        Matrix transpose := method (        
            new_matrix := Matrix clone
            	
        	new_matrix dim(
        		self size,
        		self at(0) size
        	)
        	
        	for(iy, 1, self size,
        		for(ix, 1, self at(iy-1) size,
        			new_matrix set(iy, ix, 
        				self get(ix, iy) 
        			)
        		)
        	)
        	
        	return new_matrix    	
        )

7. Write the matrix to a file, and read the matrix from a file.

        Matrix save := method (fn,
        	f := File with(fn)
        	f remove
        	f openForAppending

        	for(iy, 1, self size,
        		f write(
        			self at(iy-1) join(","), "\n"			
        		)
        	)

        	f close
        )

        Matrix load := method (fn,
        	f := File with(fn)
        	f openForReading
        	matrix := list()

        	f foreachLine(i, v,
        		matrix append (v split(",")) 
        	)
        	
        	return matrix
        )

8. Write a program that gives you ten tries to guess a random number from 1-100. If you would like, give a hint of "hotter" or "colder" after the first guess.

        numb := Random value(100) round
        tries := 0
        guess := nil

        while (guess != numb and tries <= 10, 
        	tries = tries + 1
        	writeln("Guess a number from zero to one hundred")
        	guess := File standardInput readLine asNumber

        	if(guess < numb and tries == 1, writeln("Hotter"))
        	if(guess > numb and tries == 1, writeln("Colder"))
        )

        if(guess == numb, writeln("Correct!"), writeln("Game Over!"))