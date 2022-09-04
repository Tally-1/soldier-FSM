params["_man"];
_man addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];

	
	//used in the stayInCover function
	[_unit, "Last_Hit", time] call SFSM_fnc_unitData;
	_unit setVariable ["SFSM_enemy", _source];

	//check conditions before initiating healing
	private _action = [_unit, "action"] call SFSM_fnc_unitData;
	if("hunker" in _action)exitWith{};

	
	if(_action == "Holding cover position")
	exitWith{//Stop holding if the man is in a cover-pos
				[_unit, (getPos _unit), true] call SFSM_fnc_endStayInCover; 
				"end cover, hit by bullet" call dbgmsg;
			};

	if!([_unit] call SFSM_fnc_canSelfHeal)exitWith{};
	
	private _legDamage = getAllHitPointsDamage _unit # 2 # 10;
	
	if(_legDamage > 0.4)
	then{[_unit] spawn SFSM_fnc_proneHeal};
			
		
}];