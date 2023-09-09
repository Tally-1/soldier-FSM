// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_hidePos", "_enemyVehicle"];
private _battleKey   = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battleField = SFSM_battles get _battleKey;
private _timer       = time + 60;

// private _script = 
[_man, _battleField, _timer] call SFSM_fnc_initHideFromVeh;
// waitUntil{sleep 0.1; scriptDone _script};


if(isNil "_battleField")                    exitWith{"cannot hide, battle ended" call dbgmsg};
if([_enemyVehicle]call Tcore_fnc_deadCrew)    exitWith{"won't hide, vehicle is not operational" call dbgmsg};
if(!alive _man)                                exitWith{"cannot hide, man died" call dbgmsg};
if(time > _timer)                            exitWith{"cannot hide, timed out" call dbgmsg};


[_man, _hidePos, _enemyVehicle] spawn SFSM_fnc_moveToHidePos;

true;