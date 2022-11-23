missionNamespace setVariable ["SFSM_Version", 0.43, true];
private _versionName = ["DCO soldier FSM V. ", SFSM_Version] joinString "";


[
	"SFSM_disableSoldierFSM",
	"CHECKBOX",
	["Disable soldier FSM", "Disables all functions upon mission-init"],
	_versionName,
	false
] call cba_settings_fnc_init;

[
	"SFSM_Debugger",
	"CHECKBOX",
	["Debugger", "show debug-info, and 3D markers"],
	_versionName,
	false
] call cba_settings_fnc_init;

[
	"SFSM_globalUD",
	"CHECKBOX",
	["Global unit-data", "(experimental), Set this to false to reduce net-traffic. May affect client-players debug-mode."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_allowFlinching",
	"CHECKBOX",
	["Flinch", "Units will flinch on incoming fire."],
	_versionName,
	true
] call cba_settings_fnc_init;



[
	"SFSM_allowDodging",
	"CHECKBOX",
	["Dodge", "Units will dodge (change position) when incoming fire reaches the dodge-trigger-treshHold (SFSM_RpsDodgeTrigger)."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_dodgeIndoors",
	"CHECKBOX",
	["Dodge indoors", "Toggle if a soldier can dodge / take cover while indoors."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_PlayerGrpDodge",
	"CHECKBOX",
	["Dodge, player groups", "Allows units in a group lead by a player to dodge / hide. Dodging can be frustrating for players who like to micro-manage their AI"],
	_versionName,
	false
] call cba_settings_fnc_init;

[
	"SFSM_ExcludeZcommand",
	"CHECKBOX",
	["No zeus dodge", "stop units that have been given waypoints by a curator from dodging"],
	_versionName,
	false
] call cba_settings_fnc_init;

//Deactivated as of version 0.34. The force dodge is necesary, no need to let the end-user mess things up
// [
// 	"SFSM_forceDodge",
// 	"CHECKBOX",
// 	["Force Dodge", "Override the Vanilla FSM in order to force the unit to move when dodging, if disabeled the unit will sometimes ignore incoming fire and just stay like an idiot."],
// 	_versionName,
// 	true
// ] call cba_settings_fnc_init;

[
	"SFSM_legHealingOn",
	"CHECKBOX",
	["Emergency heal", "If a soldier is hit in the legs, he will inmediately go prone and heal himself, to allow for running."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_flinchStopDodge",
	"CHECKBOX",
	["flinch Stops Dodge", "if this is toggled then the unit will stop running towards cover and instead flinch"],
	_versionName,
	false
] call cba_settings_fnc_init;

[
	"SFSM_breakCoverOnHit",
	"CHECKBOX",
	["Hit stops cover-holding", "If hit while in cover the unit will move away from current position. (does not affect hunker-down mechanism)"],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_hideFromVehicles",
	"CHECKBOX",
	["Hide from vehicles", "Units will run away / hide from vehicles they cannot hurt."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_hearingHide",
	"CHECKBOX",
	["Hide by hearing vehicle", "A Vehicle with engine ON is detected within hearing-distance"],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_AtSpecHuntVehicles",
	"CHECKBOX",
	["Hunt vehicles", "Units with launchers will target enemy vehicles instead of hiding."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_emergencyRearm",
	"CHECKBOX",
	["Emergency rearm", "Soldiers pick up launchers from killed soldiers if a enemy vehicle is nearby."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_mgSuppressClusters",
	"CHECKBOX",
	["MG suppression", "MachineGunners will spray enemy positions upon initial contact."],
	_versionName,
	true
] call cba_settings_fnc_init;



[
	"SFSM_noCoverPanic",
	"CHECKBOX",
	["panic upon lack of cover", "Yip's much wanted eyelid trench, if no cover is found upon battle-start the unit panics for about 2 seconds"],
	_versionName,
	false
] call cba_settings_fnc_init;

[
	"SFSM_houseDemolition",
	"CHECKBOX",
	["House Demolition", "Allow units with explosives in their backPack to blow up houses. (!DANGER!)"],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_rpgHouse",
	"CHECKBOX",
	["RPG houses", "Allow units with launchers to fire their launchers at buildings with enemies inside."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_hijackVehicles",
	"CHECKBOX",
	["Hijack Vehicles", "Units will get in available vehicles as driver / gunner."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_hearingDistance",
	"SLIDER",
	["Hearing distance", "Max distance a vehicle will be reacted to by hearing, (if in a urban area, half of this distance is used)."],
	_versionName,
	[
		0,   	//minimum 
		500, 	//max
		250,    //default
		0,	    //decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_hidingTimeOut",
	"SLIDER",
	["Hiding timeOut", "The max amount of time a unit will stay in a hiding-pos before returning to normal. (hiding is triggered by the presence of a enemy vehicle)"],
	_versionName,
	[
		5,   	//minimum 
		120, 	//max
		30,    //default
		0,	    //decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_overrunDistance",
	"SLIDER",
	["Overrun distance", "If an enemy comes within this range while holding cover / hiding the unit will try to evade the enemy, set to 0 to deactivate."],
	_versionName,
	[
		0,   	//minimum 
		80, 	//max
		40,    //default
		0,	    //decimals
		false
	],
	1
] call cba_settings_fnc_init;

#include "\soldierFSM\functions\PR\customCBA.sqf"

/*
Deactivated as of version 0.297, we are now using the vanilla EH that came with
A3 #2.10
[
	"SFSM_enableCustomEH",
	"CHECKBOX",
	["Enemy spotted eventHandler", "Enable custom eventhandler for enemy-spotted. Deactivating this is VERY good for performance."],
	_versionName,
	true
] call cba_settings_fnc_init;

*/
[
	"SFSM_CQBdistance",
	"SLIDER",
	["Init CQB distance", "Distance to enemy inside a building needed to activate CQB-mode."],
	_versionName,
	[
		15,   	//minimum 
		90, 		//max
		30,    //default
		0,	    //decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_CQBunitCap",
	"SLIDER",
	["CQB unit-cap", "The maximum amount of units that can clear the same house at the same time. For a challenge set it to 4 and over."],
	_versionName,
	[
		1,   	//minimum 
		10,		//max
		2,      //default
		0,	    //decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_KnowledgeToFight",
	"SLIDER",
	["Knowledge needed to engage", "the amount of knowledge needed to start a battle upon enemy spotted."],
	_versionName,
	[
		0,   	//minimum 
		4, 		//max
		0.1,    //default
		2,	    //decimals
		false
	],
	1
] call cba_settings_fnc_init;

//Deactivated as of version 0.34. Not really needed. Removed to reduce confusion.
// [
// 	"SFSM_FlinchTreshHold",
// 	"SLIDER",
// 	["Flinch TreshHold", "unit will not flinch if suppression is higher than this value"],
// 	_versionName,
// 	[
// 		0,   	//minimum 
// 		2, 		//max
// 		0.1,    //default
// 		2,		//decimals
// 		false
// 	],
// 	1
// ] call cba_settings_fnc_init;





[
	"SFSM_FlinchCoolDown",
	"SLIDER",
	["Flinch CoolDown", "Minimum Time between each flinch-response"],
	_versionName,
	[
		1,   	//minimum 
		120, 	//max
		5, 		//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;



[
	"SFSM_RpsDodgeTrigger",
	"SLIDER",
	["Dodge Trigger", "Continous Incoming bullets with no more than 1 second break, to trigger Dodging"],
	_versionName,
	[
		2,   	//minimum 
		30, 	//max
		4, 		//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_stayCoverPosTime",
	"SLIDER",
	["Stay in cover time", "the amount of seconds the soldier will stay in his position upon taking cover."],
	_versionName,
	[
		0,   	//minimum 
		40, 	//max
		20,		//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_sprintSpeed",
	"SLIDER",
	["Sprint Speed", "speed coef for dodging / taking cover / hiding. 1 = vanilla. 2 = twice the normal speed"],
	_versionName,
	[
		1,   	//minimum 
		2.4,    //max
		1.2, 	//default
		1,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;




[
	"SFSM_DodgeCoolDown",
	"SLIDER",
	["Dodge CoolDown", "Time between each possible dodge-response"],
	_versionName,
	[
		2,   	//minimum 
		30, 	//max
		10,		//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_DodgeDistance",
	"SLIDER",
	["Dodge Distance", "How far the man will run when dodging"],
	_versionName,
	[
		30,   	//minimum 
		80, 	//max
		60, 	//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_explosionCoverRad",
	"SLIDER",
	["explosion Cover Radius", "if munition explodes within this distance from the soldier he will run for cover."],
	_versionName,
	[
		60,   	//minimum 
		200, 	//max
		70, 	//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_reactFireCoolDown",
	"SLIDER",
	["React fire coolDown", "Time between each time a unit inmediately barrages the enemy upon incoming fire"],
	_versionName,
	[
		60,   	//minimum 
		300, 	//max
		180, 	//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_DodgeTimer",
	"SLIDER",
	["Dodge Timer", "Max time before ending a dodge / sprint."],
	_versionName,
	[
		10,   	//minimum 
		90, 	//max
		40, 	//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_ProneTreshHold",
	"SLIDER",
	["Prone TreshHold", "unit will stay prone if suppression is higher than this value"],
	_versionName,
	[
		0.1,   	//minimum 
		2, 		//max
		0.7, 	//default
		2,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;



[
	"SFSM_panicCoef",
	"SLIDER",
	["panic Coef", "chance that a man will panic upon start of engagement if he cannot see a cover-position"],
	_versionName,
	[
		0,   	//minimum 
		1, 		//max
		0.5, 	//default
		1,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;