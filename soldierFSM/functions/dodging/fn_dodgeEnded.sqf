params ["_man", "_endPos", "_timer"];

if(isNil "_endPos")	exitWith{true};
if(isNil "_man")	exitWith{true};
if(!alive _man)		exitWith{true};
if(time > _timer)	exitWith{true};
if((_man distance2D _endPos) < (2))exitWith{true};

private _action = [_man, "action"] call SFSM_fnc_unitData;

if(_action in ["reacting", "flinch"])
exitWith{true};


false