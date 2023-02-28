addMissionEventHandler ["EntityKilled", {
	params ["_man", "_killer", "_instigator", "_useEffects"];

	private _unitData = _man getVariable "SFSM_UnitData";
	if(isNil "_unitData")    exitWith{};
	if!([_man] call SFSM_fnc_isRealMan)exitWith{};

	_man setVariable ['SFSM_killTime', time];

	private _building = _unitData get "currentBuilding";
	if!(_building == "none")
	then{missionNamespace setVariable [_building, nil, true];};

	private _battleKey = _unitData get "currentBattle";
	if(_battleKey == "none")exitWith{};

	//add the deceased to the battlefield-hashmap.
	private _battleField = SFSM_Battles get _battleKey;
	missionNamespace getVariable (_battleField get "deadMen") pushBack _man;

	[_man] spawn SFSM_fnc_AddWeaponsToBattlefield;
	[_man] spawn SFSM_fnc_pickUpFreshAT;	
	
}];