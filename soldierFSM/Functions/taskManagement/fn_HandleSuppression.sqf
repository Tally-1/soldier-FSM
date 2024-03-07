// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];
if!([_man] call SFSM_fnc_isRealMan)exitWith{};

//if man is in a vehicle
if!(typeOf (vehicle _man) == typeOf _man)exitwith{};

//no players should be affected by this function
if([_man] call SFSM_fnc_isPlayer)exitWith{};


private _action         = [_man, "action"]                call SFSM_fnc_unitData;
private _lastBullet     = [_man, "Last_Close_Bullet"]     call SFSM_fnc_unitData;
private _proneTreshHold = [_man] call SFSM_fnc_getProneTreshHold;

if((time - _lastBullet) > 1)    
then{[_man, "roundsPrSecond", 0] call SFSM_fnc_unitData};

[_man, "current suppression", (getSuppression _man)] call SFSM_fnc_unitData;


//sometimes the flinch-action does not exit properly, this is a failsafe
if(((time - _lastBullet) > 3)
&&{_action == "flinch"})
then{[_x, "action", "none"] call SFSM_fnc_unitData};

if([_man] call SFSM_fnc_canNormalizeStance)
exitwith{
    
//3x spam, because ArmA, some functions do not execute for unknown reasons.
    _man setUnitPos "AUTO";
    _man setUnitPos "AUTO";
    _man setUnitPos "AUTO";
    [_man] call SFSM_fnc_normalizeStance;
    };

if(_action isNotEqualTo "none")exitWith{};

if((getSuppression _man) > _proneTreshHold)
then{_man setUnitPos "DOWN"};

true;