params["_man"];
_man addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];

	if([_unit] call Tcore_fnc_nilNull)exitWith{};
	if([_unit] call Tcore_fnc_isPlayer)exitWith{};
	
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
	
	if(_legDamage > 0.4)exitWith{[_unit] spawn SFSM_fnc_proneHeal;};

	private _canHealBody = (damage _unit)>0.3 
						 &&{SFSM_EmergencyHealing == "whole-body"
						 &&{_action isEqualTo "none"}};
	
	if(_canHealBody)exitWith{[_unit] spawn SFSM_fnc_proneHeal;};

	true;
		
}];