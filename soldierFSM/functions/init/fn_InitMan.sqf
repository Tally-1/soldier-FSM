// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
private _data = _man getVariable "SFSM_UnitData";
if(!isNil "_data")exitWith{};
// if!([_man] call SFSM_fnc_isRealMan)exitWith{};

// if(isPlayer _man)exitwith{};
if([(group _man)] call Tcore_fnc_nilNull)exitWith{};

[_man] call SFSM_fnc_initUnitData;

_man setVariable["SFSM_prevTarget",     objNull,   true];
_man setVariable["SFSM_prevShooter",    objNull,   true];

if(_man getVariable ["SFSM_Excluded",false])exitWith{};

[_man] call SFSM_fnc_SuppressedEH;
[_man] call SFSM_fnc_firedEH;
[_man] call SFSM_fnc_hitEH;

_man addEventHandler ["InventoryOpened",  {_this call SFSM_fnc_onInventoryOpened;}];
_man addEventHandler ["AnimStateChanged", {_this call SFSM_fnc_onAnimChange}];

[_man] call SFSM_fnc_autoStanceActions;
[_man] call SFSM_fnc_buddyRearmAction;
[_man] call SFSM_fnc_playerCallMedicAction;

true;