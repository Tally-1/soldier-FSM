params["_group"];
private _playerGroup = false;

{
    if([_x, true] call SFSM_fnc_isPlayer)
    exitWith{_playerGroup = true;};
    
} forEach units _group;

_playerGroup;