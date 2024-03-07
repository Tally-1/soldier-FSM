private _versionName = "DCO soldier FSM | Actions";

[
	"SFSM_emergencyRearm",
	"CHECKBOX",
	["Emergency rearm", "Soldiers pick up launchers, machineGuns and ammo from killed soldiers."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_throwBackGrenade",
	"CHECKBOX",
	["Throw back Grenade", "Enables soldiers to throw back incoming handgrenades."],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_reactFireCoolDown",
	"SLIDER",
	["React fire coolDown", "Time between each time a unit inmediately barrages the enemy upon incoming fire"],
	_versionName,
	[
		30,   	//minimum 
		300, 	//max
		180, 	//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;

[
	"SFSM_audioFeedbackType",
	"LIST",
	["AI audio feedback", "Select how soldiers status is relayed to the player."],
	_versionName,
	[
		["voice_text", "voice", "english", "none"],
		["Voice and text", "Voice Only", "Only English speaking units", "No feedback."], 
		1
	]
] call cba_settings_fnc_init;