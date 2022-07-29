params ["_man"];
sleep 1;
private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield = SFSM_Battles get _battleKey;

if(isNil "_battlefield")exitWith{};

private _unitPos        = getPos _man;
private _droppedWeapons = _unitPos nearObjects ["WeaponHolderSimulated", 5];
private _placedWeapons  = _unitPos nearObjects ["WeaponHolder", 5];
_droppedWeapons append _placedWeapons;

private _weaponCount    = count _droppedWeapons;

if(_weaponCount == 0)exitWith{["could not find weapons close to dead man", 2] call dbgmsg};

private _weaponsVar = (_battlefield get "weapons");

{
	(missionNamespace getVariable _weaponsVar) pushBackUnique _X;
	_x setVariable ["SFSM_weaponOwner", _man];
} forEach _droppedWeapons;



private _finalCount = count (missionNamespace getVariable _weaponsVar);

[[
	_weaponCount, 
	" weapons were added to battlefield-data. ",
	_finalCount,
	" weapons cached"
]] call dbgmsg;



true;