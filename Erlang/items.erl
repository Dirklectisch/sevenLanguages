-module(items).
-export([find/2]).
-export([totals/1]).

find(Item, Items) -> [Value || {Key, Value} <- Items, Key == Item].

totals(Products) -> [{Item, Quantity * Price} || {Item, Quantity, Price} <- Products].