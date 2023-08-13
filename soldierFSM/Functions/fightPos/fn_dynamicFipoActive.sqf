params["_fipo", "_man"];
if(_fipo getVariable "dynamicFipo" isEqualTo false)exitwith{};

private _unitsInSector = [_fipo] call SFSM_fnc_unitsInFireSector;
if(_unitsInSector isEqualTo [])exitWith{false;};

private _enemies = _unitsInSector select {[_man, _x] call SFSM_fnc_validEnemy;};
if(_enemies isEqualTo [])exitWith{
	_fipo setVariable ["active", false];
	false;
};

_fipo setVariable ["active", true];

true;