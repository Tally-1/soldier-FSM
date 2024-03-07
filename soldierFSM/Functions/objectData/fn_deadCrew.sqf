params [
	["_vehicle", nil, [objNull]]
];
private _group   = (group _vehicle);
private _allDead = true;

if(IsNil "_vehicle")            exitWith{true};
if((crew _vehicle) isEqualTo [])exitwith{true};
if(!Alive _vehicle)             exitWith{true};
if(IsNil "_group")              exitWith{true};
if(IsNull _group)               exitWith{true};


{
	if([_x] call SFSM_fnc_functionalMan)
	exitWith{_allDead = false};

} forEach (Crew _vehicle);


_allDead;