-module(test_control).

-export([move/0]).

move() ->
	{counterserver, 'server@student-246-135'} ! {self(), "move"}.
