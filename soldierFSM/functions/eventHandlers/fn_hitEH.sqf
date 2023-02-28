params["_man"];
_man addEventHandler ["Hit", {
	params ["_man", "_source", "_damage", "_instigator"];

	private _vehicle = vehicle _man;
	private _inVehicle = typeOf _vehicle != typeOf _man;

	if([_man] call Tcore_fnc_nilNull)exitWith{};
	if([_man] call Tcore_fnc_isPlayer)exitWith{};

	//Remove damage if caused by sprinting
	if(_man getVariable ["SFSM_Sprinting",false]
	&&{isNull _instigator})exitWith{
		["Damage caused by sprinting", 2] call dbgmsg;
		private _dmg = damage _man; 
		_man setDamage (_dmg - _damage);
		true;
	};
	
	//used in the stayInCover function
	[_man, "Last_Hit", time] call SFSM_fnc_manData;
	_man setVariable ["SFSM_enemy", _source];

	//check conditions before initiating healing
	private _action = [_man, "action"] call SFSM_fnc_manData;
	if("hunker" in _action)exitWith{};

	//Stop holding if the man is in a cover-pos
	if(_action == "Holding cover position")
	exitWith{
				[_man, (getPos _man), true] call SFSM_fnc_endStayInCover; 
				"end cover, hit by bullet" call dbgmsg;
			};

	if!([_man] call SFSM_fnc_canSelfHeal)exitWith{};
	if("eviv" in _action)exitwith{};
	if(_man getVariable ["SFSM_Sprinting", false])   exitwith{false;};

	private _legDamage = getAllHitPointsDamage _man # 2 # 10;
	
	if(_legDamage > 0.4)exitWith{[_man] spawn SFSM_fnc_proneHeal;};
	

	private _canHealBody = (damage _man)>0.3 
						 &&{SFSM_EmergencyHealing == "whole-body"
						 &&{_action isEqualTo "none"}};
	
	if(_canHealBody)exitWith{[_man] spawn SFSM_fnc_proneHeal;};

	//stop bleeding if ACE is in use
	if(SFSM_aceLoaded 
	&&{(_man getVariable ["ace_medical_woundbleeding", 0]) > 0.1
	&&{SFSM_EmergencyHealing == "whole-body"}})exitWith{
		[_man] spawn SFSM_fnc_proneHeal;
	};

	true;
		
}];

