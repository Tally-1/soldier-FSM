params["_group"];
private _leader      = leader _group;
private _battleField = [_leader] call SFSM_fnc_getBattlefield;
if(isNil "_battleField")exitWith{false;};

private _units = missionNamespace getVariable (_battleField get "units") select {[_x, true, true, true] call SFSM_fnc_canRun};
if(_units isEqualTo [])exitWith{false;};

private _friendlies = [];
private _enemies    = [];

{
    if([_x, _leader] call SFSM_fnc_hostile)
    then{_enemies    pushBack _x}
    else{_friendlies pushBack _x};
    
} forEach _units;

private _enemyStrength = (count _enemies)/(count _friendlies);
private _battleLost    = _enemyStrength > 4;

_battleLost;