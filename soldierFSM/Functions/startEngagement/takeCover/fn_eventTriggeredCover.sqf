// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_enemyPos"];
if(_man getVariable ['SFSM_excluded', false])exitWith{};
private _takeCoverIndoors = false;
private _canDodge    = [_man, true] call SFSM_fnc_canDodge;

//random chance to init CQB cover (50%)
if(random 1 > 0.5
&&{_canDodge})
then{
      private _house = [(getPos _man), SFSM_DodgeDistance] call SFSM_fnc_nearestAvailableHouse;
      if (isNil '_house') exitWith {};
      private _coverPos = [_man, _house, false] call SFSM_fnc_moveIntoHouseInit;
      if!(_coverPos isEqualTo [0,0,0])
      then{_takeCoverIndoors = true};
};

if(_takeCoverIndoors)exitWith{};

private _coverPos = [_man] call Tcore_fnc_coverPosSimple;
if(isNil "_coverPos")
exitWith{[_man, _enemyPos, false] spawn SFSM_fnc_Dodge};
[_man, _coverPos] spawn SFSM_fnc_takeCover;