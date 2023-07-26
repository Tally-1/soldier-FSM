params ["_groupArr"];
private _units = [];

{
    private _men = [_x] call SFSM_fnc_marksmenInGroup;
    _units append _men;
    
} forEach _groupArr;

_units;