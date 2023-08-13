params["_man", "_enemy"];
private _grpPos   = [((units group _man)apply{getPosASL _x})] call Tcore_fnc_avgPos;
if(([_grpPos] call SFSM_fnc_isPosition) isEqualTo false) exitWith{(getDir _man -180)};

private _evadeDir = [_man getDir _grpPos] call Tcore_fnc_formatDir;

if(isNil "_enemy" 
||{!alive _enemy}) exitWith{_evadeDir;};

private _evadeEnemyDir = (_man getDir _enemy) + (selectRandom [0-90,90]); //[ + (_evadeDir)] call Tcore_fnc_formatDir;
private _avgEvadeDir   = [[_evadeEnemyDir, _evadeDir]] call Tcore_fnc_average;

_avgEvadeDir;