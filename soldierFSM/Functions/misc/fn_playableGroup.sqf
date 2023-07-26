params ["_group"];
private _units = units _group;
private _playable = false;

{
    private _playerUnit = [_x] call SFSM_fnc_playableUnit;
    if(_playerUnit)exitWith{_playable = true};
    
} forEach _units;

_playable;