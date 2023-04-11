private _ignoreReactFireTimer = false;
params ["_man", "_ignoreReactFireTimer"];
if(isNil "_man")exitWith{false};
if(_man getVariable ["SFSM_Sprinting", false])   exitwith{false;};
if(_man getVariable ["ace_isunconscious", false])exitWith{false;};
if(_man getVariable ["dam_ignore_injured0",false])exitWith{false;};


private _reactFireTimer	= [_man, "reactFireTimer"] 	call SFSM_fnc_unitData;
private _action 	 	= [_man, "action"] 	 		call SFSM_fnc_unitData;
private _rps 	 		= [_man, "roundsPrSecond"] 	call SFSM_fnc_unitData;

(_rps < SFSM_RpsDodgeTrigger
&&{(_reactFireTimer < time || _ignoreReactFireTimer)//when hit by a bullet the reactF-timer is ignored.
&&{(_action == 'none')}})