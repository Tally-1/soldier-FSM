private _versionName = "DCO soldier FSM | Movement";

[
	"SFSM_allowFlinching",
	"CHECKBOX",
	["Flinch", "Units will flinch on incoming fire."],
	_versionName,
	true
] call CBA_fnc_addSetting;

[
	"SFSM_flinchStopDodge",
	"CHECKBOX",
	["flinch Stops Dodge", "if this is toggled then the unit will stop running towards cover and instead flinch"],
	_versionName,
	false
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;


[
	"SFSM_allowDodging",
	"CHECKBOX",
	["Dodge", "Units will dodge (change position) when incoming fire reaches the dodge-trigger-treshHold (SFSM_RpsDodgeTrigger)."],
	_versionName,
	true
] call CBA_fnc_addSetting;

[
	"SFSM_allowEvasion",
	"CHECKBOX",
	["Evasion", "When no cover is found a soldier will run to avoid incoming fire."],
	_versionName,
	true

] call CBA_fnc_addSetting;


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
] call CBA_fnc_addSetting;


[
	"SFSM_maxSprinters",
	"SLIDER",
	["Max simultaneous sprinters", "Max amount of sprinters allowed at one instance."],
	_versionName,
	[
		3,   	//minimum 
		40, 	//max
		15,     //default
		0,	    //decimals
		false
	],
	1
] call CBA_fnc_addSetting;


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
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;


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
] call CBA_fnc_addSetting;


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
] call CBA_fnc_addSetting;


[
	"SFSM_dodgeIndoors",
	"CHECKBOX",
	["Dodge indoors", "Toggle if a soldier can dodge / take cover while indoors."],
	_versionName,
	true
] call CBA_fnc_addSetting;


[
	"SFSM_PlayerGrpDodge",
	"CHECKBOX",
	["Dodge, player groups", "Allows units in a group lead by a player to dodge / hide. Dodging can be frustrating for players who like to micro-manage their AI"],
	_versionName,
	false
] call CBA_fnc_addSetting;


[
	"SFSM_ExcludeZcommand",
	"CHECKBOX",
	["No zeus dodge", "stop units that have been given waypoints by a curator from dodging"],
	_versionName,
	false
] call CBA_fnc_addSetting;


[
	"SFSM_explosionCoverRad",
	"SLIDER",
	["explosion Cover Radius", "if munition explodes within this distance from the soldier he will run for cover."],
	_versionName,
	[
		40,   	//minimum 
		200, 	//max
		70, 	//default
		0,		//decimals
		false
	],
	1
] call CBA_fnc_addSetting;


[
	"SFSM_breakCoverOnHit",
	"CHECKBOX",
	["Hit stops cover-holding", "If hit while in cover the unit will move away from current position. (does not affect hunker-down mechanism)"],
	_versionName,
	true

] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;


[
	"SFSM_noCoverPanic",
	"CHECKBOX",
	["panic upon lack of cover", "Yip's much wanted eyelid trench, if no cover is found upon battle-start the unit panics for about 2 seconds"],
	_versionName,
	false
] call CBA_fnc_addSetting;


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
] call CBA_fnc_addSetting;

