params ["_man"];
private _flinchTimer 	= [_man, "flinchTimer"] 		call SFSM_fnc_unitData;
private _flinching 	 	= [_man, "flinching"] 	 		call SFSM_fnc_unitData;
private _lastSupression	= [_man, "current suppression"] call SFSM_fnc_unitData;
private _dodging 		= [_man, "dodging"] 			call SFSM_fnc_unitData;

(true//_lastSupression == 0 /*unknown intention from the designers, need clarification*/
&&{_flinchTimer < time
&&{(!(_flinching))
&&{(!(_dodging))
&&{getSuppression _man < SFSM_FlinchTreshHold}}}})