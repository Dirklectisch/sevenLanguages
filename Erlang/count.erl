-module(count).
-export([words/1]).
-export([to/1]).
-export([report/1]).

words([]) -> 0;
words([_|[]]) -> 1;
words([_,32|Rest]) -> 1 + words(Rest);
words([_|Rest]) -> 0 + words(Rest).

to(0) -> [0];
to(N) -> [N|to(N-1)].

report(success) -> io_lib:print(success);
report({error, Message}) -> io_lib:print(string:concat("error: ", Message)).