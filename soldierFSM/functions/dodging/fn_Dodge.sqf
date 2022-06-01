params ["_man", "_enemy"];

/*Set values to the unitData hashmap */
private _coolDown = (time + SFSM_DodgeCoolDown);
[_man, "dodgeTimer", _coolDown] call SFSM_fnc_unitData;
[_man, "dodging", 	 true] 		call SFSM_fnc_unitData;
[_man, "action", 	"dodging"]	call SFSM_fnc_unitData;

private _target		= getAttackTarget _man;
private _behaviour  = behaviour _man;

private _timer 		= time + SFSM_DodgeTimer;
private _dodgePos 	= [_man, _enemy] call SFSM_fnc_GetDodgePos;


if(SFSM_forceDodge)
then{
	//_man disableAI "FSM";
	_man disableAI "TARGET";
	_man disableAI "AUTOCOMBAT";
	_man disableAI "AUTOTARGET";

	_man doTarget objNull;

if(stance _man == "prone")then{_man setUnitPos "MIDDLE"};
	//_man setUnitPos "AUTO";
	//_man setBehaviourStrong "CARELESS";
};


_man moveTo _dodgePos;
_man doMove _dodgePos;

[_man, _dodgePos, _timer, _target, _behaviour] spawn SFSM_fnc_EndDodge;