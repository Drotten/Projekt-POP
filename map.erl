-module(map).
-export([main/0]).

initgunman(MainPID) ->
	random:seed(now()),
	Coordinates = {random:uniform(1000),random:uniform(1000)},
	io:format("~p~n",[{"Where do you want to go...", self(), Coordinates}]),
	{ok, Direction} = io:fread("...East,West,North or South?    ","~s"),
        MainPID ! {walk, self(), Direction, Coordinates},
        gunmanloop(MainPID,Coordinates).

walk(MainPID,Coordinates) ->
       	io:format("~p~n",[{"Where do you want to go now...", self(), Coordinates}]),
       	{ok, Direction} = io:fread("...East,West,North or South?    ","~s"),
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
			GunmanPID ! {newposition, {CoordinateX-100,CoordinateY}},
			mainloop(UserPIDs);
		    ["west"] ->
			GunmanPID ! {newposition, {CoordinateX-100,CoordinateY}},
			mainloop(UserPIDs);
		    ["w"] ->
			GunmanPID ! {newposition, {CoordinateX-100,CoordinateY}},
			mainloop(UserPIDs);
		    ["W"] ->
			GunmanPID ! {newposition, {CoordinateX-100,CoordinateY}},
			mainloop(UserPIDs);
		    ["East"] ->
			GunmanPID ! {newposition, {CoordinateX+100,CoordinateY}},
			mainloop(UserPIDs);
		    ["east"] ->
			GunmanPID ! {newposition, {CoordinateX+100,CoordinateY}},
			mainloop(UserPIDs);
		    ["e"] ->
			GunmanPID ! {newposition, {CoordinateX+100,CoordinateY}},
			mainloop(UserPIDs);
		    ["E"] ->
			GunmanPID ! {newposition, {CoordinateX+100,CoordinateY}},
			mainloop(UserPIDs);
		    ["North"] ->
			GunmanPID ! {newposition, {CoordinateX,CoordinateY+100}},
			mainloop(UserPIDs);
		    ["north"] ->
			GunmanPID ! {newposition, {CoordinateX,CoordinateY+100}},
			mainloop(UserPIDs);
		    ["n"] ->
			GunmanPID ! {newposition, {CoordinateX,CoordinateY+100}},
			mainloop(UserPIDs);
		    ["N"] ->
			GunmanPID ! {newposition, {CoordinateX,CoordinateY+100}},
			mainloop(UserPIDs);
		    ["South"] ->
			GunmanPID ! {newposition, {CoordinateX,CoordinateY-100}},
			mainloop(UserPIDs);
		    ["south"] ->
			GunmanPID ! {newposition, {CoordinateX,CoordinateY-100}},
			mainloop(UserPIDs);
		    ["s"] ->
			GunmanPID ! {newposition, {CoordinateX,CoordinateY-100}},
			mainloop(UserPIDs);
		    ["S"] ->
			GunmanPID ! {newposition, {CoordinateX,CoordinateY-100}},
			mainloop(UserPIDs);
		    ["Quit"] ->
			io:format("Goodbye ~n");
		    ["quit"] ->
			io:format("Goodbye ~n");
		    _Else ->
			io:format("Invalid input, try again! ~n"),	
			GunmanPID ! {newposition, {CoordinateX,CoordinateY}},
			mainloop(UserPIDs)	      
		end	   
	end.
					   
main()->
    Main = self(),
    UserPID = spawn(fun()-> initgunman(Main) end),
    UserPIDs = [UserPID],
    mainloop(UserPIDs).
		  
