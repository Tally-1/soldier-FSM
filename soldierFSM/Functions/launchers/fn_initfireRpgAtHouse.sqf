params[
    ["_man",       nil, [objNull]],
    ["_building",  nil, [objNull]]
];
private _targetPosASL = [_man, _building] call SFSM_fnc_getHouseTargetPos;
private _handler      = [_man]  call  SFSM_fnc_launcherHandler;
private _targetPosATL = ASLToATL _targetPosASL;
private _dir          = _man getDir _building;
private _actionTxt    = "firing launcher!";

_man setVariable ["SFSM_missileTargetPos", _targetPosASL];
_man setVariable ["SFSM_rpgHandler",       _handler];
_man setVariable ["SFSM_missileTargetBuilding", _building];

[_man, "action", _actionTxt]       call  SFSM_fnc_unitData;

[_man, _targetPosATL]              spawn SFSM_fnc_forceLookAtPos;
["CQB_rpgFire", [_man, _building]] call  CBA_fnc_localEvent;


true;