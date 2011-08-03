min([Head|[]], Head).

min([First|Tail], MinTail) :-
	min(Tail, MinTail),
	MinTail<First.

min([First|Tail], First) :-
	min(Tail, MinTail),
	MinTail>First.
	
takeout(X,[X|R],R).
takeout(X,[F|R],[F|S]) :- takeout(X,R,S).

sorted([Only|[]], [Only]).

sorted(List, [Min|Tail]) :-
	min(List, Min),
	takeout(Min, List, Rest),
	sorted(Rest, Tail).