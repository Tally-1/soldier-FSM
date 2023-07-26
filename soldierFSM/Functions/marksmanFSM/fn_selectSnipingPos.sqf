params ["_marksman", "_target", "_firePositions", "_forcedCenter"];
private _targetPos     = getPosASL _target;
private _sniperPos     = getPosASL _marksman;
private _dir           = [_sniperPos getDir _targetPos] call Tcore_fnc_formatDir;
private _distance      = _target distance _marksman;

// private _center        = [_targetPos, _sniperPos, (_distance*0.8)] call Tcore_fnc_getMidPoint;
private _rightFlank    = [_sniperPos, (_dir+90), (_distance*0.5)]  call SFSM_fnc_sinCosPos2;
private _leftFlank     = [_sniperPos, (_dir-90), (_distance*0.5)]  call SFSM_fnc_sinCosPos2;

// select where the priority flank is, 
// then the firePosition will be the nearest available to that flank
private _opPositions    = [_leftFlank, _sniperPos, _rightFlank];
private _descriptors    = ["left", "center", "right"];
private _i              = floor random 3;

if(_forcedCenter)
then{_i = 1;};

private _flank          = _opPositions#_i;
private _flankDesc      = _descriptors#_i;

if!(_forcedCenter)
then{(["Marksman chose the ", _flankDesc, " flank"] joinString "") call dbgmsg;};

private _firePos = [_flank, _firePositions] call SFSM_fnc_getNearest;

if(isNil "_firePos")exitWith{};

_firePos;