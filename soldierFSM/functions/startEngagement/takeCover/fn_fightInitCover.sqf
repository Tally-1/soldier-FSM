// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

/*
    DESCRIPTION:
    called from battlefieldPostInit, sends units to nearest coverPos if available.
*/
params ["_man", "_battlefield"];
if!([_man] call SFSM_fnc_isrealMan)exitwith{};
if([_man] call SFSM_fnc_isMarksman)exitwith{};

private _pathEnabeled  = [_man, 'pathEnabeled']     call SFSM_fnc_unitData;
if!(_pathEnabeled)exitwith{"path disabeled, unit will not take cover" call SFSM_fnc_debugMessage};

private _enemy       = ([_man, nil, 'enemies'] call Tcore_fnc_nearKnownEnemies)#0;
private _coverPos    = [_man] call SFSM_fnc_getCoverPos;
private _posFound    = ((!isNil "_coverPos") && {typeName _coverPos == "Array"});
private _enemyFound  = ((!isNil '_enemy') && {(!isNull _enemy)});
private _panic       = (random 1) < SFSM_panicCoef;
private _canDodge    = [_man, true] call SFSM_fnc_canDodge;
private _takeCoverIndoors = false;

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


if((!(_posFound ))
&& {_panic 
&& {SFSM_noCoverPanic}})
exitWith
{
    [_man] spawn SFSM_fnc_eyelidTrench;
};

if((!_posFound) 
&&{_canDodge
&&{_enemyFound}})
exitWith{[_man, _enemy] spawn SFSM_fnc_dodge};

if(_posFound)exitWith{[_man, _coverPos] spawn SFSM_fnc_takeCover};

"No pos, no panic" call dbgmsg;