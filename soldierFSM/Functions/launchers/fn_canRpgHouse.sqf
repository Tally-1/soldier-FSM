// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
private _launcher     = secondaryWeapon _man;
private _launcherType = ([_launcher] call objScan_fnc_weaponData) get "description";
if!(SFSM_rpgHouse)                                    exitWith{false;};
if!([_man] call SFSM_fnc_availableAiSoldier)          exitWith{false;};
if(_launcher isEqualTo "")                            exitWith{false;};
if(_launcherType == "AA misile launcher")             exitWith{false;};
if!([_man, _launcher] call SFSM_fnc_hasAmmoForWeapon) exitWith{false;};


true;