private _versionName = "DCO soldier FSM | Capture";


[
	"SFSM_bombOnCapture",
	"SLIDER",
	["Captured Bomb probability", "The probability that a captured soldier blows himself up."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		0.2, //   default
		2,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_captureExplosive",
	"LIST",
	["Captured Bomb-type", "Choose which explosive will be used in the case of capture suicide."],
	_versionName,
	[
		["gbu", "grenade", "largestEx"],
		["GBU", "Grenade", "Largest explosive in Inventory"], 
		1
	]
] call cba_settings_fnc_init;

[
	"SFSM_captureAbuseProb",
	"SLIDER",
	["Abuse probability", "Probability that a captive will be beaten."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		0.5, //   default
		1,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_cptrAbuseProbPlr",
	"SLIDER",
	["Abuse player probability", "Probability that a captured player will be beaten."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		1,   //   default
		1,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_captureExecProb",
	"SLIDER",
	["Execute captive probability", "Probability that a captive Will be executed."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		1,   //   default
		1,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_cptrExecProbPlr",
	"SLIDER",
	["Execute captive probability", "Probability that a captured player will be executed."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		0.9, //   default
		1,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_cptrPlrEscProb",
	"SLIDER",
	["Player escape probability", "The probability for success when a player attempts to break free while captured."],
	_versionName,
	[
		0,     // minimum 
		1, 	  //  max
		0.5, //   default
		1,  //    decimals
		true
	]
] call cba_settings_fnc_init;

[
	"SFSM_cptrPlrEscTime",
	"SLIDER",
	["Player escape time", "How long one escape attempt takes in seconds."],
	_versionName,
	[
		3,     // minimum 
		15,   //  max
		7,   //   default
		0,  //    decimals
		true
	]
] call cba_settings_fnc_init;
