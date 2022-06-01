params ["_man"];
private _flinchTimer 	= [_man, "flinchTimer"] 		call Tally_Fnc_SFSM_unitData;
private _flinching 	 	= [_man, "flinching"] 	 		call Tally_Fnc_SFSM_unitData;
private _lastSupression	= [_man, "current suppression"] call Tally_Fnc_SFSM_unitData;
private _dodging 		= [_man, "dodging"] 			call Tally_Fnc_SFSM_unitData;

(true//_lastSupression == 0 /*unknown intention from the designers, need clarification*/
&&{_flinchTimer < time
&&{(!(_flinching))
&&{(!(_dodging))
&&{getSuppression _man < SFSM_FlinchTreshHold}}}})