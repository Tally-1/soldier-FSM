// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
private _leader = (leader (group _man)) == _man;

if(_leader)                              exitWith{"squad-leader"};
if([_man] call SFSM_fnc_isMedic)         exitWith{"medic"};
if([_man] call SFSM_fnc_isATSoldier)     exitWith{"AT-specialist"};
if([_man] call SFSM_fnc_isMachineGunner) exitWith{"machineGunner"};
if([_man] call SFSM_fnc_isMarksman)      exitWith{"marksman"};



"regular"