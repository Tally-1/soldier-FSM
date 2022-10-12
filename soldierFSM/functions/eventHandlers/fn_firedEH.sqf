params ["_man"];

_man addEventHandler ["Fired", {
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
	
	[_unit] 							 call SFSM_fnc_triggerBattleOnShot;
	[_unit, _muzzle, _weapon] 			 call SFSM_fnc_multiplyReactionFire;
	[_unit] 							 call SFSM_fnc_soundReaction;
	[_unit, "last_bullet_fired", time] 	 call SFSM_fnc_unitData;
	[_projectile, _ammo, _unit, _gunner] call SFSM_fnc_projectileEH;
	
	SFSM_lastShotFired = time;
    
	true;
}];