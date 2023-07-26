// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

/*
This function is useless, only keep it as a possible future project to work on.
Main reason is that SQF does not allow for this type of move.

*/

params["_man", "_enemies"];

if(isNil "_enemies")    then {_enemies = [_man] call Tcore_fnc_nearKnownEnemies};
if(count _enemies == 0) exitWith {"no enemies found" call dbgmsg};

private _launcher = (secondaryWeapon _man);
if(_launcher == "")exitWith{"no launcher found" call dbgmsg};

private _target = [_man, _enemies] call Tcore_fnc_nearestPos;
private _timer = time +5;

[_man, "action", "Targeting infantry"] call SFSM_fnc_unitData;

_man selectWeapon _launcher;
waitUntil{sleep 0.1; (currentWeapon _man == _launcher or (time > _timer))};

_man doFire _target;
"firing" call dbgmsg;


sleep 5;

[_man, "action", "none"] call SFSM_fnc_unitData;

