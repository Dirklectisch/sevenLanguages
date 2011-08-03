## Find: ##

- Find some implementations of a Fibonacci series and factorials. How do they work?

    Fibonacci:
    
        fib(0,0).
        fib(1,1).
        fib(N,F) :-
        	N>1, N1 is N-1, N2 is N-2,
        	fib(N1,F1), fib(N2,F2),
        	F is F1+F2.
        	
    -- Start by asking for the Nth number in the sequence.
        
        fib(4, What).
        
    -- The first two rules don't apply so the third rule in unified like this:
    
        fib(4, F) :-
            4>1, N1 is 4-1, N2, is 4-2,
            fib(3, F1), fib(2, F2),
            F is F1+F2.
            
    -- Prolog continues by attempting to unify the 4th and 5th subgoal in the same manner. Eventually it will hit upon fib(0,0) and fib(1,1) facts which give it enough information to work its way back up to the requested Fibonacci number.
    
        fib(4, 3) :-
            4>1, N1 is 4-1, N2, is 4-2,
            fib(3, 2), fib(2, 1),
            F is 2+1.
            
    Factorial:
    
        fact(0,1).
        fact(N,F) :- 
            N>0, N1 is N-1, 
            fact(N1,F1), 
            F is N*F1.
    
    -- Start by asking the factorial of N.

        fact(5, What).
        
    -- The first fact doesn't apply so the second rule is unified.
    
        fact(5, F) :-
            5>0, N1 is 5-1,
            fact(4, F1),
            F is 5*F1
            
    -- It recursively unifies the third subgoal until it hits the fact(0,1) fact.
    
        fact(5, 120) :-
            5>0, N1 is 5-1,
            fact(4, 24),
            F is 5*24
        
- Find a real-world community using Prolog. What problems are they solving?

    One example of a project in active development is Thea. A collection of modules for parsing and manipulating OWL2 ontologies in Prolog. Their mailing list can be found here: http://groups.google.com/group/thea-owl-lib

- Find an implementation of the Towers of Hanoi. How does it work?

    A Towers of Hanoi implementation is thoroughly explained on this page: http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/2_3.html

- What are some of the problems dealing with "not" expressions? Why do you have to be careful with negation in Prolog?

    Negative goals ?-not(g) with variables cannot be expected to produce bindings of the variables for which the goal g fails.

    http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/2_5.html

## Do: ##

- Reverse the elements of a list.

        reversal([Head|[]], [Head]).
        reversal([Head|Tail], Reversed) :-
        	reversal(Tail, RevTail),
        	append(RevTail, [Head], Reversed).

- Find the smallest element of a list.

        min([Head|[]], Head).

        min([First|Tail], MinTail) :-
        	min(Tail, MinTail),
        	MinTail<First.

        min([First|Tail], First) :-
        	min(Tail, MinTail),
        	MinTail>First.

- Sort the elements of a list.

        takeout(X,[X|R],R).
        takeout(X,[F|R],[F|S]) :- takeout(X,R,S).

        sorted([Only|[]], [Only]).

        sorted(List, [Min|Tail]) :-
        	min(List, Min),
        	takeout(Min, List, Rest),
        	sorted(Rest, Tail).