params["_group"];
private _data     = _group getVariable "SFSM_groupData";
private _cmbtSide = side _group in [east,west,independent];
private _valid    = (!isNil "_data")&&{_cmbtSide};
if!(_valid)exitWith{};

private _leader     = leader _group;
private _units      = units _group;
private _nearFiposs = [_group] call SFSM_fnc_nearGroupFiposs;
private _available  = _units select {[_x] call SFSM_fnc_canMoveInFipo && {_x distance _leader < 50}};

[_available, _nearFiposs] call SFSM_fnc_assignFiposs;


true;