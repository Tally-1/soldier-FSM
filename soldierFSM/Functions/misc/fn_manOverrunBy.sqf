// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params['_man'];
private _nearEnemies = [_man, SFSM_overrunDistance, 'enemies'] call Tcore_fnc_nearKnownEnemies;
private _overRun = count _nearEnemies > 0;

if(_overRun)exitwith{(_nearEnemies#0)};

objNull;