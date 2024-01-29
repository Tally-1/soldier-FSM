// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_vehicle"];
if!(SFSM_hearingHide)              exitWith{false;};
if!(isEngineOn _vehicle)           exitWith{false;};
if(_man knowsAbout _vehicle < 3.5) exitWith{false;};

private _hearingDistance = SFSM_hearingDistance;
private _distance        = (_man distance2D _vehicle);
private _areaName        = [_man] call Tcore_fnc_areaName;
private _inUrbanArea     = (count (_areaName splitString " ")) isEqualTo 1;

if(_inUrbanArea)then{_hearingDistance = (SFSM_hearingDistance/2);};

if(_distance > _hearingDistance)exitWith{false;};

true;