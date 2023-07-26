params ["_man", "_vehicle"];
if (_vehicle isKindOf "man")                exitWith{false;};
if!(_vehicle isKindOf "land")               exitWith{false;};
if!([_man, _vehicle] call SFSM_fnc_hostile) exitWith{false;};
if ([_vehicle] call Tcore_fnc_deadCrew)     exitWith{false;};


true;