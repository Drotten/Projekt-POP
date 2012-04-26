-module(test).

-export([start/0]).

start() ->
    {testserver, 'server@beurling'} ! {self(), "counter"},
    receive
	{ok, Counter} ->
	    io:format("Counter is at value: ~p~n", [Counter])
    end.
