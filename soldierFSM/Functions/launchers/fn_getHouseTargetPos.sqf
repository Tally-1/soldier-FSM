/*
This function tries to find a window or door near the enemy target.
If no window is found a position on the wall is returned.
If no position on the wall is found the center position of the building is returned.
*/
params[
    ["_shooter",  nil, [objNull]],
    ["_building", nil, [objNull]],
    ["_minHeight", 1.2,      [0]]
];
private _centerPosASL = [_building] call SFSM_fnc_buildingCenterPosASL;
private _targetMan    = [_shooter, _building] call SFSM_fnc_getHouseTargetMan;
if!([_shooter, _targetMan] call SFSM_fnc_validEnemy)exitWith{_centerPosASL};

private _startPos = eyePos _targetMan;
private _endPos   = [_startPos, aimpos _shooter, 10] call SFSM_fnc_posOnvector;
private _z        = selectMax [_startPos#2, _endPos#2];

_endPos = [_endPos#0, _endPos#1, _z];

private _surfaces = (lineIntersectsSurfaces [_startPos, _endPos, _targetMan, objNull, false, 3, "GEOM", "FIRE", true])select{_x#3 isEqualTo _building;};
if(_surfaces isEqualTo [])exitWith{_centerPosASL;};

private _surfaceData     = _surfaces#0;
private _wallPosASL      = _surfaceData#0;
private _altitude        = (ASLToATL _wallPosASL)#2;
private _validWallpos    = _altitude >= _minHeight;
private _windowsAndDoors = [_building] call SFSM_fnc_getHousePoints
                           select{
                              private _pos = _x#0;
                              private _ASL = ATLToASL _pos;
                              (_wallPosASL distance (_ASL)) < 2.5
                           };
if(_windowsAndDoors isEqualTo []
&&{_validWallpos    isEqualTo false})
exitWith{_centerPosASL};

if(_windowsAndDoors isEqualTo []
&&{_validWallpos    isEqualTo true})
exitWith{_wallPosASL};

_windowsAndDoors = _windowsAndDoors apply {ATLToASL (_x#0)};

// private _shooterPos = getPosASLVisual _shooter;
private _nearest    = [_wallPosASL, _windowsAndDoors] call SFSM_fnc_getNearest;


_nearest;