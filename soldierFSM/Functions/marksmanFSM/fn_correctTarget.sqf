params ["_marksman"];
private _currentTrgt = getAttackTarget _marksman;
private _target = _marksman getVariable ["SFSM_myTarget", objNull];
private _wrongTarget = ((!isNull _target) &&{_target isNotEqualTo _currentTrgt});
if!(_wrongTarget)exitWith{false;};

_marksman setUnitCombatMode "WHITE";
_marksman forgetTarget _currentTrgt;
_marksman reveal _target;
_marksman doTarget _target;

true;