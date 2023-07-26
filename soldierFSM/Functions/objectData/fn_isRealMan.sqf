// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _ignoreUnitData = false;
params[
    "_man",            // Object - The unit to check
    "_ignoreUnitData"  // Bool   - Ignore the unitData check
];

if!(typeName _man isEqualTo "OBJECT")   exitWith {false};
if!(alive _man)                         exitWith {false};
if!(_man isKindOf "CAManBase")          exitWith {false};

private _group = group _man;
if(isNull _group)                       exitWith {false};
if(side _group == sideLogic)            exitWith {false};
if([_man] call SFSM_fnc_isDeactivated)  exitWith {false};
if(isObjectHidden _man)                 exitWith {false};

if(_ignoreUnitData)exitWith{true};

private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")   exitWith {false};

true;