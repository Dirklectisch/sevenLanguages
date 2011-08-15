## Find: ##

- The Erlang language's official site
  
  http://www.erlang.org/

- Official documentation for Erlang's functional library

  http://www.erlang.org/doc/reference_manual/users_guide.html

- The documentation for Erlang's OTP library

  http://www.erlang.org/doc/apps/stdlib/index.html

## Do: ##

- Write a function that uses recursion to return the number of words in a string.

```erlang
words([]) -> 0;
words([_|[]]) -> 1;
words([_,32|Rest]) -> 1 + words(Rest);
words([_|Rest]) -> 0 + words(Rest).
```

- Write a function that uses recursion to count to ten.

```erlang
to(0) -> [0];
to(N) -> [N|to(N-1)].
```

- Write a function that uses matching to selectively print "success" or "error: message" given input of the form {error, message} or success.

```erlang
report(success) -> io_lib:print(success);
report({error, Message}) -> io_lib:print(string:concat("error: ", Message)).
```