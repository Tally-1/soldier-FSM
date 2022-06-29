params ["_man"];
private _reactFireTimer	= [_man, "reactFireTimer"] 	call SFSM_fnc_unitData;
private _action 	 	= [_man, "action"] 	 		call SFSM_fnc_unitData;
private _rps 	 		= [_man, "roundsPrSecond"] 	call SFSM_fnc_unitData;

(_rps < SFSM_RpsDodgeTrigger
&&{_reactFireTimer < time
&&{(_action == 'none')}})