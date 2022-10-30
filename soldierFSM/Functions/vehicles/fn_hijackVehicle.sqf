params["_vehicle", "_units"];
private _filter = {((_vehicle distance _x) < SFSM_DodgeDistance)
                &&{[_x, "action"]call SFSM_fnc_unitData == "none"
				&&{[_x, "pathEnabeled"]call SFSM_fnc_unitData
				&&{(!(_x getVariable ["SFSM_Excluded",false]))
				&&{typeOf _x == typeOf (vehicle _x)}}}}};

_units = ([_units, [], {_vehicle distance _x }, "ASCEND"] call BIS_fnc_sortBy);
_units = _units select _filter;

if(_units isEqualTo [])exitWith{};

[_vehicle, (_units#0)] spawn SFSM_fnc_getInVehicle;

if(count _units == 1)exitWith{};

[_vehicle, (_units#1), "driver"] spawn SFSM_fnc_getInVehicle;

true;