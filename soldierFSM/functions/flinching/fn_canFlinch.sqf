params ["_man"];

if!(SFSM_allowFlinching)exitWith{false}; 

private _flinchTimer 	= [_man, "flinchTimer"] 		call SFSM_fnc_unitData;
private _action 	 	= [_man, "action"] 	 		    call SFSM_fnc_unitData;
private _stopDodge      = (SFSM_flinchStopDodge && {"dodging" in _action});
private _available      = _action == 'none'
                        or _stopDodge;


if(_stopDodge)
then{"stopping dodge" call dbgmsg};

(true//_lastSupression == 0 /*unknown intention from the designers, need clarification*/
&&{_flinchTimer < time
&&{_available
&&{getSuppression _man < SFSM_ProneTreshHold}}})//last condition might be unnecesary