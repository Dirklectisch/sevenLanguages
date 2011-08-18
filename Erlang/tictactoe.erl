-module(tictactoe).
-export([report_status/1]).
-export([test/0]).
    
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
        
test() ->
    BoardA = [o,null,null,
              x,x,x,
              o,o,null],
    BoardB = [o,null,o,
              x,x,o,
              x,null,o],
    BoardC = [x,null,o,
              o,x,o,
              x,null,x],
    BoardD = [x,null,o,
              x,o,x,
              o,null,x],
    BoardE = [x,null,o,
              x,null,x,
              o,null,x],
    BoardF = [x,x,o,
              o,x,x,
              x,o,o],
    TestCases = [BoardA, BoardB, BoardC, BoardD, BoardE, BoardF],
    [report_status(TC) || TC <- TestCases].
    
        