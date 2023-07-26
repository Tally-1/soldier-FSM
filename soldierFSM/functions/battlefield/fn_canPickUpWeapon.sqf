//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: determines if a man can pick up a weapon from the ground.

// Params:[_man:object, _weaponObject:object]

// Return value: boolean

// Example: [_man, _weaponObject] call SFSM_fnc_canPickupWeapon;

params["_man", "_weaponObject"];
if(isNil "_man")                                   exitwith{false;};
if(isNil "_weaponObject")                          exitwith{false;};
if(isNull _weaponObject)                           exitwith{false;};
if!([_man] call SFSM_fnc_canRun)                   exitWith{false;};
if ([_man] call SFSM_fnc_isPlayer)                 exitWith{false;};

private _special     = !(([_man] call SFSM_fnc_squadAsset) isEqualTo "regular");
private _weaponType  = (getWeaponCargo _weaponObject#0#0);
private _classId     = ([_weaponType] call objScan_fnc_weaponData) get "class ID";
private _machinegun  = ((_classId > 2.5 && {_classId < 4})
                        or (_classId >= 1.7 && {_classId <= 1.8}));
private _launcher    = "auncher" in (_weaponType call BIS_fnc_itemType)#1;
private _blocked     = _special && {_machinegun || _launcher};


if(_blocked)exitwith{false;};

true;