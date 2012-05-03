-module(map).
-export([main/0]).

initgunman(MainPID) ->
	random:seed(now()),
	Coordinates = {random:uniform(1000),random:uniform(1000)},
	io:format("~p~n",[{"Where do you want to go...", self(), Coordinates}]),
	{ok, Direction} = io:fread("...East,West,North or South?","~s"),
        MainPID ! {walk, self(), Direction, Coordinates},
        gunmanloop(MainPID,Coordinates).

walk(MainPID,Coordinates) ->
       	io:format("~p~n",[{"Where do you want to go now...", self(), Coordinates}]),
       	{ok, Direction} = io:fread("...East,West,North or South?","~s"),
        MainPID ! {walk, self(), Direction, Coordinates}.


gunmanloop(MainPID, Coordinates) ->
	receive
		{newposition, Newcoordinates} ->
		walk(MainPID,Newcoordinates),
		gunmanloop(MainPID,Newcoordinates)
	end.

		
mainloop(UserPIDs) ->
	receive
		{walk, GunmanPID, Direction, {CoordinateX,CoordinateY}} ->
		case Direction of
		    ["West"] ->
			GunmanPID ! {newposition, {CoordinateX+100,CoordinateY}},
			mainloop(UserPIDs);
		    _ ->
			io:format("~p ~n",Direction),	
			GunmanPID ! {newposition, {CoordinateX,CoordinateY}},
			mainloop(UserPIDs)	      
		end
	end.
						   
main()->
    io:format("MHMM"),
    Main = self(),
    UserPID = spawn(fun()-> initgunman(Main) end),
    UserPIDs = [UserPID],
    mainloop(UserPIDs).
		  
