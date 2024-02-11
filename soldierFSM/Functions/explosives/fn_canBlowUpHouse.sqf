// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Determines if a AI soldier is able to demolish a building.

// Params: [_man:object, _building:object]

// Return value: Boolean

// Example: [_mySoldado, _myBuilding] call SFSM_fnc_canBlowUpHouse

params["_man", "_building"];
if!(SFSM_houseDemolition)                                   exitWith{false;};
if(!alive _man)                                             exitWith{false;};
if([_man] call SFSM_fnc_getChargeFromBackPack isEqualTo []) exitWith{false;};
if(((getPosATL _building)#3)<0)                             exitWith{false;};
if!([_man, true] call SFSM_fnc_canRun)                      exitWith{false;};
if([_man, true] call SFSM_fnc_isPlayer)                     exitWith{false;};

//Random coef based on the courage of the unit.
private _braveEnough = (_man skill "courage")>=(random 1);
if!(_braveEnough)exitWith{"no demo, no courage" call dbgmsg; false;};

private _friendlies = ([_building] call SFSM_fnc_unitsInBuilding) select {side _x isEqualTo side _man;};
if(_friendlies isNotEqualTo [])
exitWith{false;};

true;