params ["_fipo"];
private _show = _fipo getVariable "showIndicators";

[_fipo, true] call FIPO_fnc_fipoSectorsAdjustedWidth;

if!(_show)exitWith{
    [_fipo] call FIPO_fnc_deleteIndicators;
};

[_fipo] call FIPO_fnc_spawnIndicators;
[_fipo] call FIPO_fnc_updateIndicators;

{
    private _flankVar = _fipo getVariable _x;
    if(isNil "_flankVar"
    ||{typeName _flankVar isEqualTo "BOOL"})
    then{_fipo setVariable [_x, -1];};
    
} forEach ["rightFlank", "leftFlank"];


true;