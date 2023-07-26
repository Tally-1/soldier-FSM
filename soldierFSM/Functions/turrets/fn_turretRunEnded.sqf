// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_turret", "_timer"];
if([_man, _turret] call SFSM_fnc_canGetInTurret)exitwith{true;};
if(time > _timer)exitwith{true;};
if(!alive _man)exitwith{true;};
if(_man getVariable ["ace_isunconscious", false])exitwith{true;};
if(_man getVariable ["dam_ignore_injured0",false])exitWith{false;};
if(!([_turret, true] call SFSM_fnc_turretAvailable))exitwith{true;};
false;