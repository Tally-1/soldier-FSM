// This function adds a variable to FIPOs that are set to be disabeled when FUBAR.
// FUBAR happens when a unit has just been killed / knocked out while in the FIPO.
// FUBAR can also happen if the position is on the second floor of a building that 
// Got dammaged.

params["_man"];
private _inFipo = [_man, "inFipo"] call SFSM_fnc_unitData;
if(_inFipo isEqualTo false)exitWith{};

private _fipo = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")exitWith{};

private _canFubar = _fipo getVariable "fubardisable";
if(_canFubar isEqualTo false)exitWith{};

_fipo setVariable ["lastKnockout", (round time)];

["FIPO_knockedOut", [_man, _fipo]] call CBA_fnc_localEvent;

[_man, _fipo] call SFSM_fnc_fipoQuickRevive;

true;