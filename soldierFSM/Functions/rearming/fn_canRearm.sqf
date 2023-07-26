// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];

if!(SFSM_emergencyRearm)                        exitWith{false;};
if!([_man] call SFSM_fnc_canRun)                exitWith{false;};
if (_man getVariable ["SFSM_Sprinting", false]) exitwith{false;};
if ([_man] call SFSM_fnc_isPlayer)              exitWith{false;};


private _action        = [_man, "action"]         call SFSM_fnc_unitData;
private _battle        = [_man, "currentBattle"]  call SFSM_fnc_unitData;
private _lastAmmoCheck = [_man, "last_AmmoCheck"] call SFSM_fnc_unitData;

if(_action isNotEqualTo "none") exitWith{false;};
if(_battle isEqualTo "none")    exitWith{false;};
if(time - _lastAmmoCheck < 10)  exitWith{false;};

true;