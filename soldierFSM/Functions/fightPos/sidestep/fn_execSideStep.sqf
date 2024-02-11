params[
    ["_man",          nil, [objNull]],
    ["_anim",         nil,      [""]],
    ["_returnStep", false,   [false]]
]; 
private _fipo      = [_man] call SFSM_fnc_getFipo;
private _speedCoef = getAnimSpeedCoef _man;
if(isNil "_fipo")exitWith{};
if(_speedCoef > 1)then{_man setAnimSpeedCoef 1;};

private _startPos    = getPosATLVisual _man;
private _fipoDist    = _man distance2D _fipo;
private _fipoDir     = getDirVisual _fipo;
private _anims       = [_anim];
private _maxDistance = (SFSM_moveAnims call ["getMapByCfgName", [_anim]])get"distance";
private _endAnim     = animationState _man;
private _condition   = {[_man] call SFSM_fnc_execSideStepCondition;};
private _midFnc      = {[_man] call SFSM_fnc_execSideStepMid;};

_man setVariable ["SFSM_ignoreFipo",   true];
_man setVariable ["SFSM_fipoDir",     _fipoDir];
_man setVariable ["SFSM_returnStep",  _returnStep];
_man setVariable ["SFSM_stepEndAnim", _endAnim];


_man setDir _fipoDir;
_man disableAI "anim";
_man disableAI "move";
_man disableAI "fsm";

private _timer    = time + 5;
private _velocity = velocityModelSpace _man;

[_man, _anims, true, _condition, _midFnc] call  SFSM_fnc_playAnimList;


waitUntil {
    sleep 0.1;
    _velocity         = velocityModelSpace _man;
    private _pos      = getPosATLVisual _man;
    private _distance = _startPos distance _pos;


    if(_distance >= _maxDistance)
    exitWith{
      [_man] call SFSM_fnc_forceAnimStop;
      true;
    };

    (_velocity isEqualTo [0,0,0]
    ||{time > _timer});
};

[_man] call SFSM_fnc_execSideStepEnd;

true; 