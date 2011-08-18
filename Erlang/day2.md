## Do: ##

- Consider a list of keyword-value tuples, such as [{erlang, "a functional language"}, {ruby, "an OO language"}]. Write a function that accepts the list and a keyword and returns the associated value for the keyword.

```erlang
find(Item, Items) -> [Value || {Key, Value} <- Items, Key == Item].
```

- Consider a shopping list that looks like [{item quantity price}, ...]. Write a list comprehension that builds a list of items of the form [{item, total_price}], where total_price is quantity times price.

```erlang
totals(Products) -> [{Item, Quantity * Price} || {Item, Quantity, Price} <- Products].
```

Bonus Problem

- Write a program that reads a tic-tac-toe board presented as a list or a tuple of size nine. Return the winner (x or o) if a winner has been determined, cat if there are no more possible moves, or no_winner if no player has won yet.

```erlang
-module(tictactoe).
-export([report_status/1]).
    
check_line(Line, [H|Players]) ->
    [{H, lists:all(fun(X) ->  X == H end, Line)}|check_line(Line, Players)];
    
check_line(_, []) ->
    [].
    
check_lines(Lines) ->
    [check_line(Line, [x,o])|| Line <- Lines].
    
split_rows([H1,H2,H3|Board]) ->
    [[H1,H2,H3]|split_rows(Board)];

split_rows(_) ->
    [].
 
split_cols([[H1|R1],[H2|R2],[H3|R3]]) ->
    [[H1,H2,H3]|split_cols([R1,R2,R3])];

split_cols([[],[],[]]) ->
    [].

split_diag([[D1,_,_], [_,D2,_], [_,_,D3]]) -> [D1,D2,D3].

get_wins(Board) ->
    Rows = split_rows(Board),
    Cols = split_cols(Rows),
    DiagA = split_diag(Rows),
    DiagB = split_diag(lists:reverse(Rows)),
    check_lines(lists:merge([Rows, Cols, [DiagA, DiagB]])).
            
filter_wins(Lines) ->
    lists:usort([Player||{Player, true} <- lists:flatten(Lines)]).

report_status(Board) ->
    Wins = filter_wins(get_wins(Board)),
    OWon = lists:any(fun(X) -> X == o end, Wins),
    XWon = lists:any(fun(X) -> X == x end, Wins),
    EmptySpaces = lists:any(fun(X) -> X == null end, Board),
    
    if
        OWon == true -> io_lib:print("Player O has won the game");
        XWon == true -> io_lib:print("Player X has won the game");
        true -> if
                    EmptySpaces == true -> io_lib:print("The game hasn't ended yet");
                    EmptySpaces == false -> io_lib:print("It's a draw")
                end
    end.
```