params["_man", "_supplyObject"];

if(isNil "_man")exitWith{false;};
if(isNil "_supplyObject")exitWith{false;};
if(isNull _supplyObject)exitWith{false;};
if(!alive _man)exitwith{false;};
if((_supplyObject distance2D _man) > 5)exitwith{false;};

private _hasMags = ([(primaryWeapon _man), _supplyObject] call SFSM_fnc_hasMagsForWeapon)>0;
if(! _hasMags)exitwith{false;};

true;