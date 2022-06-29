params["_man"];
_man addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];
	private _action = [_man, "action"] call SFSM_fnc_unitData;
	if("hunker" in _action)exitWith{};

	if!([_unit] call SFSM_fnc_canSelfHeal)exitWith{};
	
	private _legDamage = getAllHitPointsDamage _unit # 2 # 10;
	
	if(_legDamage > 0.4)
	then{[_unit] spawn SFSM_fnc_proneHeal};
			
		
}];