private _versionName = "DCO soldier FSM | Sound Reaction";

[
	"SFSM_shotDistanceDef",
	"SLIDER",
	["Default sound distance", "Default distance a man will hear enemy fire"],
	_versionName,
	[
		10,   	//minimum 
		1000, 	//max
		300,    //default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_shotDistanceAss",
	"SLIDER",
	["Assault Rifle sound distance", "The distance a man will hear enemy Assault rifles firing"],
	_versionName,
	[
		10,   	//minimum 
		1000, 	//max
		400,    //default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_shotDistanceMac",
	"SLIDER",
	["Machinegun sound distance", "The distance a man will hear enemy Machine Guns firing"],
	_versionName,
	[
		10,   	//minimum 
		1000, 	//max
		600,    //default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_shotDistanceSni",
	"SLIDER",
	["Sniper rifle sound distance", "The distance a man will hear enemy Sniper Rifles firing"],
	_versionName,
	[
		10,   	//minimum 
		1000, 	//max
		800,    //default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_shotDistanceSil",
	"SLIDER",
	["Silenced weapons sound distance", "The distance a man will hear enemy Silenced weapons firing."],
	_versionName,
	[
		10,   	//minimum 
		1000, 	//max
		100,    //default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;