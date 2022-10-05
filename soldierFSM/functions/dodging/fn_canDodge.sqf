private _noRpsParam = false;
params ["_man", "_noRpsParam"];
if!(SFSM_allowDodging)exitWith{false};

private _group             = group _man;
private _grpCanDodge       = [_group] call SFSM_fnc_groupCanDodge;
private _dodgeTimer 	   = [_man, "dodgeTimer"] 		call SFSM_fnc_unitData;
private _action 	 	   = [_man, "action"] 	 		call SFSM_fnc_unitData;
private _pathEnabeled 	   = [_man, 'pathEnabeled'] 	call SFSM_fnc_unitData;
private _rps			   = [_man, "roundsPrSecond"] 	call SFSM_fnc_unitData;
private _coolDownEnded     = _dodgeTimer < time;
private _lowSuppression	   = getSuppression _man < SFSM_ProneTreshHold;
private _highRPS		   = (_rps > SFSM_RpsDodgeTrigger) || _noRpsParam;

private _canDodge = (_coolDownEnded
					&&{(_action == 'none')
					&&{_lowSuppression
					&&{_highRPS
					&&{_grpCanDodge
					&&{_pathEnabeled}}}}});

_canDodge;