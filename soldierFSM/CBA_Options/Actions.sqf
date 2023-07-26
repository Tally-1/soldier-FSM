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
	"SFSM_allowHunkerDown",
	"CHECKBOX",
	["Allow Hunker-Down", "Determine if a soldier should be able to hunker behind cover and shoot at visible enemies. (!NOT THE SAME AS FIPO!)"],
	_versionName,
	false
] call cba_settings_fnc_init;

[
	"SFSM_audioFeedback",
	"CHECKBOX",
	["Voice feedback", "AI soldiers informs of their status using a auto generated voice."],
	_versionName,
	true
] call cba_settings_fnc_init;