// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
if!([_man] call SFSM_fnc_isATSoldier)exitWith{};

private _group = (group _man);
private _groupUnits = [_group] call SFSM_fnc_availableRegulars;
private _unitCount = count _groupUnits;

if(_unitCount == 0)exitWith{};

private _nearest = [_man, _groupUnits] call Tcore_Fnc_nearestPos;

if(typeName _nearest == "SCALAR")     exitWith{};
if(!alive _nearest)                   exitWith{};
if!((vehicle _nearest) isKindOf "man")exitWith{};

private _launcher = secondaryWeapon _nearest;
if!(_launcher == "")exitWith{};

sleep 3;
[_nearest] spawn SFSM_fnc_emergencyRearm;

true;