// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _ignoreReactFireTimer = false;
params ["_man", "_ignoreReactFireTimer"];
if(isNil "_man")exitWith{false};
if(_man getVariable ["SFSM_Sprinting", false])   exitwith{false;};
if(_man getVariable ["ace_isunconscious", false])exitWith{false;};
if(_man getVariable ["dam_ignore_injured0",false])exitWith{false;};


private _reactFireTimer  = [_man, "reactFireTimer"]     call SFSM_fnc_unitData;
private _action          = [_man, "action"]              call SFSM_fnc_unitData;
private _rps             = [_man, "roundsPrSecond"]     call SFSM_fnc_unitData;

if(isNil "_reactFireTimer") exitWith{false;};
if(isNil "_action")         exitWith{false;};
if(isNil "_rps")            exitWith{false;};

(_rps < SFSM_RpsDodgeTrigger
&&{(_reactFireTimer < time || _ignoreReactFireTimer)//when hit by a bullet the reactF-timer is ignored.
&&{(_action == 'none')}})