params ["_supplies", "_man"];
private _validSupplies  = _supplies select {([(primaryWeapon _man), _x] call SFSM_fnc_hasMagsForWeapon)>0;};
if(_validSupplies isEqualTo [])exitWith{objNull};
if(count _validSupplies == 1)  exitWith{(_validSupplies#0)};

//Select the nearest supplypoint.
private _best = ([_validSupplies, [], { _man distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;

_best;