//Set default settings unless previously defined
if(isNil "SFSM_allowFlinching")
then{
		SFSM_disableSoldierFSM  = false; // disable soldier FSM
		SFSM_Debugger			= true;  // show debug-info, and 3D markers
		SFSM_allowFlinching     = true;  // Units will flinch on incoming fire.
		SFSM_allowDodging       = true;  // Units will dodge(change position) when incoming fire reaches the treshHold (SFSM_RpsDodgeTrigger).
		SFSM_hideFromVehicles   = true;  // Units will run away / hide from vehicles they cannot hurt.
		SFSM_AtSpecHuntVehicles = true;  // Units with launchers will target enemy vehicles instead of hiding.
        SFSM_mgSuppressClusters = true;  // MachineGunners will spray enemy positions upon initial contact
		SFSM_ExcludeZcommand    = false; // stop units that have been given waypoints by a curator from dodging
		SFSM_PlayerGrpDodge     = false; // Allows units in a group lead by a player to dodge / hide, dodging can be frustrating for players who like to micro-manage their AI
		// SFSM_FlinchTreshHold 	= 1;	 // unit will not flinch if suppression is higher than this value
		SFSM_ProneTreshHold 	= 0.8;	 // unit will stay prone if suppression is higher than this value
		SFSM_FlinchCoolDown		= 5;	 // Minimum Time between each flinch-response
		SFSM_RpsDodgeTrigger	= 4;	 // Continous Incoming bullets with no less than 1 second break, to trigger Dodging
		SFSM_DodgeCoolDown		= 10;	 // Time between each dodge-response
		SFSM_DodgeDistance		= 70;	 // How far the man will run when dodging
		SFSM_DodgeTimer			= 30;	 // max time before ending a dodge.
		SFSM_forceDodge			= true;  // Override the Vanilla FSM in order to force the unit to move when dodging
		SFSM_noCoverPanic       = true;  // unit will panic upon initiating a battle if no cover is found
		SFSM_reactFireCoolDown	= 180; 	 // Time between each returnFire-response		
		SFSM_panicCoef          = 0.5;   // chance that a man will panic upon start of engagement if he cannot see a cover-position
		SFSM_KnowledgeToFight   = 0;     // the amount of knowledge needed to start a battle between 2 units.
		SFSM_sprintSpeed        = 1.3;   // speed coef for dodging / taking cover / hiding. 1 = vanilla. 2 = twice the normal speed
		SFSM_stayCoverPosTime   = 15;    // the amount of time the soldier will stay in his position upon taking cover.
		SFSM_flinchStopDodge    = true;  // if this is toggled then the unit will stop running towards cover and instead flinch
		SFSM_emergencyRearm     = true;  // Soldiers pick up launchers from killed squad-mates, or off the ground if a vehicle is nearby
		SFSM_explosionCoverRad  = 200;   // if munition explodes within this distance from the soldier he will run for cover.
		SFSM_breakCoverOnHit    = true;  // if hit while in cover the unit will move away from current position
		//SFSM_explosionCrater    = true;  // Creates a dent in the terrain upon exploding ammo(the size varies according to ammo-type)
		SFSM_legHealingOn       = true;  // If a soldier is hit in the legs, he will inmediately go prone and heal himself, to allow for running.
		SFSM_dodgeIndoors       = false; // If a soldier is inside a house the "dodge" function will activate if the unit is taking heavy fire.
		
		SFSM_CQBdistance        = 100;   // Distance to enemy inside a building needed to activate CQB-mode.
		SFSM_CQBunitCap         = 2;     // The maximum amount of units that can clear the same house at the same time. (Yip wanted 2 as a default, I recomend 4).
		SFSM_hidingTimeOut      = 30;    // The max amount of time a unit will stay in a hiding-pos before returning to normal. (hiding is triggered by the presence of a enemy vehicle)
		SFSM_hearingHide        = true;  // Hide by hearing vehicle: A Vehicle with engine ON is detected within hearing-distance
		SFSM_hearingDistance    = 250;   // Max distance a vehicle will be reacted to by hearing, (if in a urban area, half of this distance is used).
		SFSM_overrunDistance    = 50;    // If an enemy comes within this range while holding cover / hiding the unit will try to evade the enemy, set to 0 to deactivate.
        SFSM_Allow_HC           = false; // Allow Headless Client to process SFSM for AI
        SFSM_Use_HC             = false; // Use Headless Client to process SFSM for AI

		SFSM_houseDemolition    = true;  // Allow units with explosives in their backpack to blow up houses instead of clearing them room by room.

};


//Make sure settings are available globally.

missionNamespace setVariable ["SFSM_FlinchTreshHold",	1, 	                    true];
missionNamespace setVariable ["SFSM_ProneTreshHold", 	SFSM_ProneTreshHold, 	true];
missionNamespace setVariable ["SFSM_FlinchCoolDown", 	SFSM_FlinchCoolDown, 	true];
missionNamespace setVariable ["SFSM_RpsDodgeTrigger", 	SFSM_RpsDodgeTrigger, 	true];
missionNamespace setVariable ["SFSM_DodgeCoolDown", 	SFSM_DodgeCoolDown, 	true];
missionNamespace setVariable ["SFSM_DodgeDistance", 	SFSM_DodgeDistance, 	true];
missionNamespace setVariable ["SFSM_DodgeTimer", 		SFSM_DodgeTimer, 		true];
missionNamespace setVariable ["SFSM_forceDodge", 		true, 		            true]; 
missionNamespace setVariable ["SFSM_Debugger", 			SFSM_Debugger, 			true]; 
missionNamespace setVariable ["SFSM_noCoverPanic", 		SFSM_noCoverPanic, 		true];
missionNamespace setVariable ["SFSM_reactFireCoolDown", SFSM_reactFireCoolDown, true];
missionNamespace setVariable ["SFSM_ExcludeZcommand", 	SFSM_ExcludeZcommand, 	true];
missionNamespace setVariable ["SFSM_PlayerGrpDodge", 	SFSM_PlayerGrpDodge, 	true];
missionNamespace setVariable ["SFSM_hideFromVehicles", 	SFSM_hideFromVehicles, 	true];
missionNamespace setVariable ["SFSM_AtSpecHuntVehicles",SFSM_AtSpecHuntVehicles,true];
missionNamespace setVariable ["SFSM_mgSuppressClusters",SFSM_mgSuppressClusters,true];
missionNamespace setVariable ["SFSM_disableSoldierFSM", SFSM_disableSoldierFSM, true];
missionNamespace setVariable ["SFSM_enableCustomEH",    false,    				true];//using the A3 2.10 eventhandler, this setting is here for legacy reasons
missionNamespace setVariable ["SFSM_allowFlinching",    SFSM_allowFlinching,    true];
missionNamespace setVariable ["SFSM_allowDodging",      SFSM_allowDodging,      true];
missionNamespace setVariable ["SFSM_panicCoef",         SFSM_panicCoef,         true];
missionNamespace setVariable ["SFSM_KnowledgeToFight",  SFSM_KnowledgeToFight,  true];
missionNamespace setVariable ["SFSM_sprintSpeed",       SFSM_sprintSpeed,       true];
missionNamespace setVariable ["SFSM_emergencyRearm",    SFSM_emergencyRearm,    true];
missionNamespace setVariable ["SFSM_explosionCoverRad", SFSM_explosionCoverRad, true];
missionNamespace setVariable ["SFSM_breakCoverOnHit",   SFSM_breakCoverOnHit,   true];
// missionNamespace setVariable ["SFSM_explosionCrater",   SFSM_explosionCrater,   true];
missionNamespace setVariable ["SFSM_legHealingOn",      SFSM_legHealingOn,      true];
missionNamespace setVariable ["SFSM_dodgeIndoors",      SFSM_dodgeIndoors,      true];

missionNamespace setVariable ["SFSM_CQBdistance",       SFSM_CQBdistance,       true];
missionNamespace setVariable ["SFSM_CQBunitCap",        SFSM_CQBunitCap,        true];
missionNamespace setVariable ["SFSM_hidingTimeOut",     SFSM_hidingTimeOut,     true];

missionNamespace setVariable ["SFSM_hearingHide",       SFSM_hearingHide,       true];
missionNamespace setVariable ["SFSM_hearingDistance",   SFSM_hearingDistance,   true];
missionNamespace setVariable ["SFSM_overrunDistance",   SFSM_overrunDistance,   true];
missionNamespace setVariable ["SFSM_Use_HC",            SFSM_Use_HC,            true];
missionNamespace setVariable ["SFSM_Allow_HC",          SFSM_Allow_HC,          true];

true;