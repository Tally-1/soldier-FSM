private _versionName = "DCO soldier FSM | Close Quarter Combat (CQB)";

[
	"SFSM_CQBdistance",
	"SLIDER",
	["Init CQB distance", "Distance to enemy inside a building needed to activate CQB-mode."],
	_versionName,
	[
		50,   	//minimum 
		150,    //max
		70,    //default
		0,	   //decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_CQBunitCap",
	"SLIDER",
	["CQB unit-cap", "The maximum amount of units that can attack the same house at the same time. For a challenge set it to 4 and over."],
	_versionName,
	[
		1,   	//minimum 
		10,		//max
		4,      //default
		0,	    //decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_rpgHouse",
	"CHECKBOX",
	["RPG houses", "Allow units with launchers to fire their launchers at buildings with enemies inside."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_houseDemolition",
	"CHECKBOX",
	["House Demolition", "Allow units with explosives in their backPack to blow up houses. (!DANGER!)"],
	_versionName,
	true
] call cba_settings_fnc_init;