params ["_group", "_newCommand"];
private _leader = leader _group;
if!([_leader] call SFSM_fnc_isPlayer) exitWith{};
if (_newCommand isNotEqualTo "MOVE")  exitWith{};

private _fipoUnits = units _group select {
    currentCommand _x isEqualTo _newCommand
    &&{[_x, "inFipo"] call SFSM_fnc_unitData
    }};

if(_fipoUnits isEqualTo [])exitWith{};

{
    _x switchMove "AmovPercMstpSrasWrflDnon";
	[_x] call SFSM_fnc_getOutFipo;
    [_x, "lastFipoAttempt", time] call SFSM_fnc_unitData;
} forEach _fipoUnits;

true;