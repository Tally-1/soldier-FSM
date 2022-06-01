params["_man"];
private _data = _man getVariable "SFSM_UnitData";
if(!isNil "_data")exitWith{};

// if(isPlayer _man)exitwith{};

private _unitData = createHashMap;

_unitData set 	["Last_Close_Bullet", 	time];
_unitData set 	["flinching", 			false];
_unitData set 	["dodging", 			false];
_unitData set 	["flinchTimer", 		time];
_unitData set 	["dodgeTimer", 			time];
_unitData set 	["roundsPrSecond", 		0];
_unitData set 	["action", 				"none"];


_man setVariable["SFSM_UnitData", _unitData, true];
[_man] call Tally_Fnc_SuppressedEH;

true;