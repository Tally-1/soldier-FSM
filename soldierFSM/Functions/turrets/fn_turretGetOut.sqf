// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_forceLeave"];
private _turret = vehicle _man;
private _stayIn = [_man, _turret, _forceLeave] call SFSM_fnc_canStayInTurret;
if(_stayIn)exitWith{false;};

[[name _man, " left his turret"]] call dbgmsg;

_man action ["getOut", _turret];
_man doFollow (leader (group _man));

[_turret, _man] call SFSM_fnc_removeTurretVars;

true;