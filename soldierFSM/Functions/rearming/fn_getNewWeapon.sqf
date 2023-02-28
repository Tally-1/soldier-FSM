params["_man"];
private _battleKey   = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield = SFSM_Battles get _battleKey;
private _weapons     = missionNamespace getVariable (_battlefield get "weapons");
private _supplies    = [_man, _battlefield, true] call SFSM_fnc_battleFieldSupplies;

_weapons = _weapons select {
		private _canBeRearmed = [_x, _supplies] call SFSM_fnc_canRearmWeapon;
		private _weaponType   = getWeaponCargo _x#0#0;
		private _newType      = !isNil "_weaponType" && {_weaponType != (primaryWeapon _man)};

		if(isNil "_newType")then{_newType = false;};

		(_canBeRearmed && { _newType });
	};

if(count _weapons < 1)exitWith{};

private _weapon = ([_weapons, [], { _man distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;

[_man, _weapon] spawn SFSM_fnc_pickUpWeapon;

true;