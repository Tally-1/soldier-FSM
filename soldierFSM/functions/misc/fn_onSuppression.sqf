// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_ammoCFG", "_shooter"];
if([_man] call SFSM_fnc_isPlayer)                  exitwith{};
if(typeOf (vehicle _man) isNotEqualTo typeOf _man) exitwith{};//if man is in a vehicle
if!([_man] call SFSM_fnc_isRealMan)                exitWith{};

private _rps         = [_man, "roundsPrSecond"] call SFSM_fnc_unitData;
private _suppression = (getSuppression _man);
private _lastBullet  = [_man, "Last_Close_Bullet"] call SFSM_fnc_unitData;


if((time - _lastBullet) < 1 )
then{_rps = _rps + 1}
else{_rps = 1};

//Store new values into unit-hashMap
[_man, "roundsPrSecond", _rps]              call SFSM_fnc_unitData;
[_man, "Last_Close_Bullet", time]           call SFSM_fnc_unitData;
[_man, "current suppression", _suppression] call SFSM_fnc_unitData;

if([_man] call SFSM_fnc_canGoProne)
then{_man setUnitPos "DOWN"};

//Select course of action
[_man, _ammoCFG, _shooter] call SFSM_fnc_initReaction;
true;