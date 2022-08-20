private _seekCover = true;
params ["_man", "_enemy", "_seekCover"];

/*Set values to the unitData hashmap */
private _coolDown = (time + SFSM_DodgeCoolDown);
[_man, "dodgeTimer", _coolDown] call SFSM_fnc_unitData;
[_man, "dodging", 	 true] 		call SFSM_fnc_unitData;


private _target		 = getAttackTarget _man;
private _behaviour   = behaviour _man;
private _timer 		 = time + SFSM_DodgeTimer;
private _dodgePos 	 = [_man, _enemy] call SFSM_fnc_GetDodgePos;
private _action      = "dodging";

private _coverRadius = SFSM_DodgeDistance / 2;
private _coverLatPos = [_man, _enemy, _coverRadius] call SFSM_fnc_getLateralPos;
private _coverPos    = [_man, _coverLatPos, _coverRadius, false] call SFSM_fnc_getCoverPos;
private _coverFound  = (!isNil "_coverPos" && {typeName _coverPos == 'ARRAY'});
private _group       = group _man;

if(_coverFound
&&{_seekCover})
then{
		_dodgePos = _coverPos;
		_action   = "dodging to cover";
	};





if(SFSM_forceDodge)
then{
	_man disableAI "TARGET";
	_man disableAI "AUTOCOMBAT";
	_man disableAI "AUTOTARGET";

	_man doTarget objNull;

if(stance _man == "prone")then{_man setUnitPos "MIDDLE"};
};

[_man, "currentDestination", _dodgePos] call SFSM_fnc_unitData;
[_man, "action", _action]	call SFSM_fnc_unitData;

_man setAnimSpeedCoef SFSM_sprintSpeed;
_group setSpeedMode 'FULL';
_man doMove _dodgePos;

[_man, _dodgePos, _timer, _target, _behaviour] spawn SFSM_fnc_EndDodge;
true;