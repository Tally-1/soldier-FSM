params["_man"];

private _index       = (_man getVariable "SFSM_animListParams")#5;
private _target      = _man getVariable "SFSM_myAttackTarget";
private _validTarget = [_target] call SFSM_fnc_functionalMan;
private _nextAnim    = _animArr#(_index+1);

if!(_validTarget)             exitWith{false;};
if(_man distance _target < 6) exitWith{
    [_man, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", _man];
    [_man, "Target too close"] spawn SFSM_fnc_flashAction; 
    false;
};

if(isNil "_nextAnim")exitWith{true;};

private _animData = SFSM_moveAnims call ["getMapByCfgName", [_nextAnim]];
private _pos      = getPosATLVisual _man; 
private _dir      = (_man getDir _target);
private _nextPos  = _animData call ["getEndPos", [_pos, _dir]];

if(isNil "_nextPos")exitWith{true;};

_pos     = [_pos#0, _pos#1, 1];
_nextPos = [_nextPos#0, _nextPos#1, 1];

private _pathBlocked = [
    (ATLToASL _pos),
    (ATLToASL _nextPos)

] call SFSM_fnc_lineBroken;

if(_pathBlocked)exitWith{
    [_man, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", _man];
    [_man, "path blocked", 0.5] spawn SFSM_fnc_flashAction;
    false;
};

true;