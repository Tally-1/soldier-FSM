private _versionName = "DCO soldier FSM | Medical";

[
	"SFSM_EmergencyHealing",
	"LIST",
	["Emergency heal", "Determine if a soldier should heal himself when hit. (could be legs only, or whole body)"],
	_versionName,
	[
		["disabeled", "legs-only", "whole-body"],
		["disabeled", "legs-only", "whole-body"], 
		1
	]
] call cba_settings_fnc_init;


[
	"SFSM_medicSearchDistance",
	"SLIDER",
	["Medic search distance", "How far a medic will run in order to revive a downed man (ACE only)"],
	_versionName,
	[
		30,   	//minimum 
		200, 	//max
		100,    //default
		0,	   //decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_dragWounded",
	"CHECKBOX",
	["Drag wounded", "ACE medical implementation. When a man is unconscious the medic will drag him to safety before reviving him"],
	_versionName,
	true
] call cba_settings_fnc_init;


[
	"SFSM_maxDragDistance",
	"SLIDER",
	["Max drag distance", "Max distance a medic can drag a wounded before reviving him"],
	_versionName,
	[
		20,   	//minimum 
		70, 	//max
		40,    //default
		0,	   //decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_minEnemyDistForHealing",
	"SLIDER",
	["No healing when enemy within", "No Reviving when known enemies are within this distance."],
	_versionName,
	[
		0,   	//minimum 
		100, 	//max
		0,      //default
		0,	   //decimals
		false
	],
	1
] call cba_settings_fnc_init;