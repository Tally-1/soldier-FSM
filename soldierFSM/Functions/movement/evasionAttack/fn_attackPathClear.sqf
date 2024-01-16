params[
    ["_man",    nil, [objNull]],
    ["_target", nil, [objNull]]
];
private _path = _self call ["getPath", [_man, _target]];
_path = [_path, [], {_man distance _x}, "ASCEND"] call BIS_fnc_sortBy;

private _startPos = ATLToASL (_path#0);
private _endPos   = ATLToASL (_path#(count _path -1));

if([_startPos, _endPos] call SFSM_fnc_lineBroken)exitWith{false;};

true;