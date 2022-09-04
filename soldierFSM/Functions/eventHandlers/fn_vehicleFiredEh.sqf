params ["_vehicle"];
_vehicle addEventHandler ["Fired", {
	params [
				"_unit", 
				"_weapon", 
				"_muzzle", 
				"_mode", 
				"_ammo", 
				"_magazine", 
				"_projectile", 
				"_gunner"
			];
	
	[_unit] 							 call SFSM_fnc_soundReaction;
	[_projectile, _ammo, _unit, _gunner] call SFSM_fnc_projectileEH;
	

	


	SFSM_lastShotFired = time; 
	true;
}];