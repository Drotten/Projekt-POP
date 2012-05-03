-module(map).
-export([main/0]).

initgunman(MainPID) ->
    MainPID ! {register, self()},
    random:seed(now()),
    Coordinates = {0,0}, %{random:uniform(100),random:uniform(100)},
  %  io:format("~p~n",[{"Where do you want to go...", self(), Coordinates}]),
  %  {ok, Direction} = io:fread("...East,West,North or South?    ","~s"),
  %  MainPID ! {walk, self(), Direction, Coordinates},
    gunmanloop(MainPID,Coordinates).

walk(MainPID,Coordinates) ->
    io:format("~p~n",[{"Where do you want to go now...", self(), Coordinates}]),
    {ok, Direction} = io:fread("...East,West,North or South?    ","~s"),
    MainPID ! {walk, self(), Direction, Coordinates}.


gunmanloop(MainPID, Coordinates) ->
    receive
	{newposition, Newcoordinates} ->
	    walk(MainPID,Newcoordinates),
	    gunmanloop(MainPID,Newcoordinates);
	{getPosition, PID} ->
	    PID ! {positon, Coordinates},
	    gunmanloop(MainPID,Coordinates)
    end.

initbot(MainPID) ->
    MainPID ! {register, self()},
    random:seed(now()),
    Coordinates = {10,0},
    io:format("GERE~n"),
    walkbot(MainPID,Coordinates),
    botloop(MainPID,Coordinates).

walkbot(MainPID,Coordinates) ->
    random:seed(now()),
    Direction = 1, % random:uniform(4),
    MainPID ! {walk, self(), Direction, Coordinates}.

botloop(MainPID, Coordinates) ->
    receive
	{newposition, Newcoordinates} ->
	    io:format("BOT: ~p ~n", [{Newcoordinates, self()}]),
	    timer:sleep(1000),
	    walkbot(MainPID,Newcoordinates),
	    botloop(MainPID,Newcoordinates);
	{getPosition, PID} ->
	    io:format("GOT IT"),
	    MainPID ! {position, Coordinates},
	    botloop(MainPID,Coordinates)
    end.

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------



impact_check([], _ , _) -> false;
impact_check([PID | PIDs], Newcoordinates, MainPID) ->
    PID ! {getPosition,MainPID},
    io:format("SENT to"),
    receive 
	{position, Coordinates} ->
	    io:format("GOT THAT AS WELL~n"),
	    if(Coordinates == Newcoordinates) ->
		    io:format("IMPACT!! :O:O ~p ~n", [PID]),
		    true;
	      true ->
		    impact_check(PIDs,Newcoordinates,MainPID)
	    end
    end.


mainloop(UserPIDs) ->
    receive
	{register, PID} ->
	    io:format("Player ~p registered! ~n", [PID]),
	    mainloop([PID | UserPIDs]);
%	{position, Coordinates} ->
%	    io:format("GOT THAT TOO"),
%	    mainloop(UserPIDs);
	{walk, GunmanPID, Direction, {CoordinateX,CoordinateY}} ->
	    case Direction of
		["w"] ->
		    if CoordinateX<1 ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY}},
			    mainloop(UserPIDs);	    
		       true ->
			    impact_check(UserPIDs, {CoordinateX-1,CoordinateY} , self()),
			    GunmanPID ! {newposition, {CoordinateX-1,CoordinateY}},
			    mainloop(UserPIDs)
		    end;
		1 ->
		    if CoordinateX<1 ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY}},
			    mainloop(UserPIDs);	    
		       true ->
			    impact_check(UserPIDs, {CoordinateX-1,CoordinateY}, self()),
			    io:format("12GERE~n"),

			    GunmanPID ! {newposition, {CoordinateX-1,CoordinateY}},
			    mainloop(UserPIDs)
		    end;

		["e"] ->
		    if CoordinateX>99 ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY}},
			    mainloop(UserPIDs);	    
		       true ->
			    GunmanPID ! {newposition, {CoordinateX+1,CoordinateY}},
			    mainloop(UserPIDs)
		    end;
		2 ->
		    if CoordinateX>99 ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY}},
			    mainloop(UserPIDs);	    
		       true ->
			    GunmanPID ! {newposition, {CoordinateX+1,CoordinateY}},
			    mainloop(UserPIDs)
		    end;

		["n"] ->
		    if CoordinateY>99 ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY}},
			    mainloop(UserPIDs);	    
		       true ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY+1}},
			    mainloop(UserPIDs)
		    end;
		
		3 ->
		    if CoordinateY>99 ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY}},
			    mainloop(UserPIDs);	    
		       true ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY+1}},
			    mainloop(UserPIDs)
		    end;
	
		["s"] ->
		    if CoordinateY<1 ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY}},
			    mainloop(UserPIDs);	    
		       true ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY-1}},
			    mainloop(UserPIDs)
		    end;

		4 ->
		    if CoordinateY<1 ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY}},
			    mainloop(UserPIDs);	    
		       true ->
			    GunmanPID ! {newposition, {CoordinateX,CoordinateY-1}},
			    mainloop(UserPIDs)
		    end;
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
    spawn(fun() -> initbot(Main) end),
    spawn(fun()-> initbot(Main) end),
    mainloop([]).
		  
