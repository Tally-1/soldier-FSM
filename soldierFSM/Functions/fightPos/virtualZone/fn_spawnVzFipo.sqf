params[
    ["_data", nil, [createHashMap]]
];

private _pos  = _data get "asl_pos";// getPosASLVisual player;//
private _dir  = _data get "dir";
private _fipo = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["SFSM_FIPO", (ASLToAGL _pos),[],0,"CAN_COLLIDE"];
private _AZs  = _data get "activationZones";

_fipo setPosWorld _pos;
_fipo setDir _dir;

{_fipo setVariable [_x, _y]} forEach _data;

_fipo synchronizeObjectsAdd _AZs;

_fipo;