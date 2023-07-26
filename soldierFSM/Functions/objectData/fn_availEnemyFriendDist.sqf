private _distance = SFSM_overrunDistance;
private _excluded = [];
params["_man", "_units", "_excluded", "_distance"];
private _allies  = [];
private _enemies = [];

{
    if(_man distance2D _x < _distance
    &&{ _x isNotEqualTo _man
    &&{(_x in _excluded) isEqualTo false
    &&{[_x] call SFSM_fnc_availableAiSoldier}}})then{

        if([_man, _x] call SFSM_fnc_hostile)
        then{_enemies pushBack _x}
        else{_allies  pushBack _x};
    };

} forEach _units;

[_allies, _enemies];