missionNamespace setVariable ["SFSM_Version", 0.291];
private _versionName = ["soldier FSM V. ", SFSM_Version] joinString "";


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

[
	"SFSM_forceDodge",
	"CHECKBOX",
	["Force Dodge", "Override the Vanilla FSM in order to force the unit to move when dodging, if disabeled the unit will sometimes ignore incoming fire and just stay like an idiot."],
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
	"SFSM_AtSpecHuntVehicles",
	"CHECKBOX",
	["Hunt vehicles", "Units with launchers will target enemy vehicles instead of hiding."],
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
	"SFSM_enableCustomEH",
	"CHECKBOX",
	["Enemy spotted eventHandler", "Enable custom eventhandler for enemy-spotted. Deactivating this is VERY good for performance."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_FlinchTreshHold",
	"SLIDER",
	["Flinch TreshHold", "unit will not flinch if suppression is higher than this value"],
	_versionName,
	[
		0.1,   	//minimum 
		2, 		//max
		0.8, 	//default
		2,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;





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
		50, 	//default
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
	["Dodge Timer", "Max time before ending a dodge."],
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