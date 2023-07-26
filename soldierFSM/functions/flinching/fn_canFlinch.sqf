// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description:

// Params:

// Return value:

// Example:

// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Checks if a unit can flinch. 

// Params: [_man:object(the unit in question)]

// Return value: boolean (true if the unit can flinch, false if not)

// Example: private _canFlinch = [_mySoldado] call SFSM_fnc_canFlinch;

params ["_man"];

if!(SFSM_allowFlinching)                           exitWith{false;}; 
if!([_man, true] call SFSM_fnc_canRun)             exitWith{false;};
if ([_man] call SFSM_fnc_isPlayer)                 exitWith{false;};
if (_man getVariable ["SFSM_Sprinting", false])    exitwith{false;};

private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")exitWith{false;};

private _flinchTimer     = [_man, "flinchTimer"] call SFSM_fnc_unitData;
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