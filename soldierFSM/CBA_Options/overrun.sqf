private _versionName = "DCO soldier FSM | Overrun";

[
	"SFSM_overRun",
	"CHECKBOX",
	["Enable overrun behaviour", "Allow overrun actions (surrender / flee / counter-attack)"],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_playerSquadOverRun",
	"CHECKBOX",
	["Overrun behaviour on player-squads", "Enable ai-soldiers in player-squads to be overrun"],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_overRunDistance",
	"SLIDER",
	["OverRun distance", "How close the enemy must be before a figthing position is overrun. If overrun the ai will fight, flee or surrender."],
	_versionName,
	[
		20,   	//minimum 
		70, 	//max
		40,     //default
		0,	    //decimals
		false
	]
] call cba_settings_fnc_init;

[
	"SFSM_allowPanic",
	"CHECKBOX",
	["Allow Panic", "If checked soldiers will Panic under the right conditions."],
	_versionName,
	true
] call cba_settings_fnc_init;


[
	"SFSM_allowSurrender",
	"CHECKBOX",
	["Allow Surrender", "If checked then soldiers will Surrender under the right conditions."],
	_versionName,
	true
] call cba_settings_fnc_init;

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
		2
	]
] call cba_settings_fnc_init;