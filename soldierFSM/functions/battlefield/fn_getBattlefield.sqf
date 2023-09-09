//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: gets a battlefield hashmap from a unit. If the unit is not in a battle, it returns nil.
// Params: [_man:object]
// Return value: [battlefield:hashmap || nil]
// Example: [_man] call SFSM_fnc_getBattlefield;

params ["_man"];
if(isNil "_man")exitwith{};

private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
if(isNil '_battleKey')exitWith{};

private _battleField    = SFSM_battles get _battleKey;
if(isNil '_battleField')exitWith{};

_battleField;