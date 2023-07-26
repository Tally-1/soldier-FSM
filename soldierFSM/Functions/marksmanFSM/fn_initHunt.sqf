params ["_marksman", "_target"];
private _firePos = getPosATL _marksman;
private _hasLOS = [_marksman, _target, 0.5] call SFSM_fnc_targetVisible;

if!(_hasLOS)then{
    _firePos = [_marksman, _target] call SFSM_fnc_snipingPos;
};

if(isNil "_firePos")exitWith{};

private _eh = [_marksman] call SFSM_fnc_marksmanTargetControlEh;
private _targetType = [_target] call SFSM_fnc_squadAsset;
//identify targetType.
if(_targetType isEqualTo "regular")
then{
    if([vehicle _target] call SFSM_fnc_isTurret)then{_targetType = "turret-gunner";};
    if([_target] call SFSM_fnc_isMarksman)then{_targetType = "marksman";};
};


private _battleKey = [_marksman, "currentBattle"] call SFSM_fnc_unitData;
private _action    = ["Hunting ", _targetType, " ", name _target] joinstring "";
private _preyEh    = [_target] call SFSM_fnc_preyHandler;

[_marksman, "action", _action] call SFSM_fnc_unitData;
[_marksman, "huntStart", time] call SFSM_fnc_unitData;

_target setVariable   ["SFSM_myAssasin",    _marksman, true];
_marksman setVariable ["SFSM_myTarget",     _target,   true];
_marksman setVariable ["SFSM_myPreyEh",     _preyEh,   true];
_marksman setVariable ["SFSM_myFirePos",    _firePos,  true];
_marksman setVariable ["SFSM_fireEh",       _eh,       true];
_marksman setVariable ["SFSM_huntBattle",   _battleKey,true];
_marksman setVariable ["SFSM_huntStartPos", (getPosATL _marksman), true];
_marksman setVariable ["SFSM_combatMode",   (unitCombatMode _marksman), true];


_marksman disableAI "TARGET";
_marksman disableAI "AUTOCOMBAT";
_marksman disableAI "AUTOTARGET";
// _marksman disableAI "FSM";

_marksman setUnitCombatMode "WHITE";

_firePos;