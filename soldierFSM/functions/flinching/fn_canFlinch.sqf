params ["_man"];

if!(SFSM_allowFlinching)exitWith{false}; 
if(_man getVariable ["SFSM_Excluded",false])     exitWith{false;};
if(_man getVariable ["ace_isunconscious", false])exitWith{false;};
if(_man getVariable ["dam_ignore_injured0",false])exitWith{false;};
if(_man getVariable ["SFSM_Sprinting", false])   exitwith{false;};

private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")exitWith{false;};

private _flinchTimer 	= [_man, "flinchTimer"] call SFSM_fnc_unitData;
private _stopDodge      = (SFSM_flinchStopDodge && {"dodging" in _action 
                        && {(!("CQB" in _action))
                        &&{!("building" in _action)}}});
private _available      = _action isEqualTo 'none'
                        or _stopDodge;

//stopDodge needs love
if(_stopDodge)
then{/*"stopping dodge" call dbgmsg*/};

private _canFlinch  = (_flinchTimer < time && {_available});


_canFlinch;