params["_Position", "_valueToAdd"];
if(!(typeName _Position == "ARRAY"))exitWith{["non-array data passed to the Add Z function"] 	call debugMessage};
if(count _Position < 3)exitWith{["less than 3 coordinates passed to the Add Z function"] 	call debugMessage};
private _newPos = [_Position select 0,
				   _Position select 1,
				   (_Position select 2) + _valueToAdd];


_newPos