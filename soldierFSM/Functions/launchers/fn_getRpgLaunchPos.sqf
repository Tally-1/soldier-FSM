params[
    ["_man",          nil,    [objNull]],
    ["_building",    objNull, [objNull]]
];

// Return current position if the RPG guy can shoot from there.
if([_man, _building] call SFSM_fnc_atValidRpgFirePos)exitWith{getPosATLVisual _man;};

private ["_launchPos"];

isNil{//Forced unschedule execution
private _areaCenter   = getPosATL _man;
private _distance     = _man distance _building;

if(_distance < 50)  then {_distance = 50;};
if(_distance > 300) then {_distance = 300;};

private _positions    = [_areaCenter, _distance, 100] call Tcore_fnc_squareGrid;
private _targetPosASL = [_building] call SFSM_fnc_buildingCenterPosASL;

_positions = [_positions, [], {_man distance2D _x}, "ASCEND"] call BIS_fnc_sortBy;

{
    if(!isNil "_launchPos")exitWith{};
    private _firePosASL = ATLToASL ([_x, 1] call Tcore_fnc_addZ);
    private _valid      = [_firePosASL, _targetPosASL, _man, _building] call SFSM_fnc_isValidRpgFirePos;
    
    if(_valid)exitWith{_launchPos = _x;};
    
} forEach _positions;

};

if(isNil "_launchPos")exitWith{};

_launchPos;