params["_units"];
private _count  = count _units;
private _morArr = [];

{
    if([_man, true, true] call SFSM_fnc_canRun)then{
        private _morale = [_man, "morale"] call SFSM_fnc_unitData;
        _morArr pushBack _morale;
    };
    
} forEach _units;

if(_morArr isEqualTo [])exitWith{};

private _avgMorale = [_morArr, true]  call SFSM_fnc_average;

_avgMorale;