if !(params [
	// Variable name, default value, expected data type
	["_man", objNull, [objNull]]
]) exitWith {false}; // Exit with false if an error occurred or default value was used.

if !(alive _man) exitWith {false};
if !(_man isKindOf "CAManBase") exitWith {false};
private _group = group _man;
if (isNull _group) exitWith {false};
if (side _group == sideLogic) exitWith {false};
private _z = _man Getvariable ["bis_fnc_moduleRemoteControl_owner", ""];
if !(_z isEqualTo "") exitwith {false};

true
