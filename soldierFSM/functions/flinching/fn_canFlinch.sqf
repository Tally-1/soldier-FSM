params ["_man"];
private _flinchTimer 	= [_man, "flinchTimer"] 		call SFSM_fnc_unitData;
private _action 	 	= [_man, "action"] 	 		call SFSM_fnc_unitData;

(true//_lastSupression == 0 /*unknown intention from the designers, need clarification*/
&&{_flinchTimer < time
&&{(_action == 'none')
&&{getSuppression _man < SFSM_ProneTreshHold}}})//last condition might be unnecesary