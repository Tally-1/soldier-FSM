addMissionEventHandler ["EntityKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	private _unitData = _unit getVariable "SFSM_UnitData";
	if(isNil "_unitData")    exitWith{};
	if!([_unit] call SFSM_fnc_isRealMan)exitWith{};

	_unit setVariable ['SFSM_killTime', time];

	private _building = _unitData get "currentBuilding";
	if!(_building == "none")
	then{missionNamespace setVariable [_building, nil, true];};

	private _battleKey = _unitData get "currentBattle";
	if(_battleKey == "none")exitWith{};

	[_unit] spawn SFSM_fnc_AddWeaponsToBattlefield;

	//add the deceased to the battlefield-hashmap.
	private _battleField = SFSM_Battles get _battleKey;
	missionNamespace getVariable (_battleField get "deadMen") pushBack _unit;
	
	
	private _asset = [_unit] call SFSM_fnc_squadAsset;
	if!(_asset == "AT-specialist")exitWith{};

	//if it is a at-specialist then get someone else to pick up the launcher.
	private _group = (group _unit);
	private _groupUnits = units _group;
	private _unitCount = count _groupUnits;

	if(_unitCount == 0)exitWith{};

	private _nearest = [_unit, _groupUnits] call Tcore_Fnc_nearestPos;
	
	if(typeName _nearest == "SCALAR")exitWith{};
	if(!alive _nearest)              exitWith{};
	if!((vehicle _nearest) isKindOf "man")exitWith{};

	private _launcher = secondaryWeapon _nearest;
	if!(_launcher == "")exitWith{};

	[_nearest]
	spawn{
			params ["_nearest"];
			sleep 3;
			[_nearest] spawn SFSM_fnc_emergencyRearm;
		};
	
}];