-module(test_control).

-export([move/0]).

move() ->
	{moveserver, 'server@beurling'} ! {self(), "move"}.
