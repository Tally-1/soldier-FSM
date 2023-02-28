params["_man", "_weaponObject"];
if(isNil "_man")                                 exitwith{false;};
if(isNil "_weaponObject")                        exitwith{false;};
if(isNull _weaponObject)                         exitwith{false;};
if(!alive _man)                                  exitwith{false;};
if(_man getVariable ["ace_isunconscious", false])exitWith{false;};

private _special     = !(([_man] call SFSM_fnc_squadAsset) isEqualTo "regular");
private _weaponType  = (getWeaponCargo _weaponObject#0#0);
private _classId     = ([_weaponType] call objScan_fnc_weaponData) get "class ID";
private _machinegun  = ((_classId > 2.5 && {_classId < 4})
						or (_classId >= 1.7 && {_classId <= 1.8}));
private _launcher    = "auncher" in (_weaponType call BIS_fnc_itemType)#1;
private _blocked     = _special && {_machinegun || _launcher};


if(_blocked)exitwith{false;};

true;