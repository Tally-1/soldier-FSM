missionNamespace setVariable ["SFSM_Version", 1.16, true];
private _versionName = ["DCO soldier FSM | ", SFSM_Version] joinString "";


[
	"SFSM_disableSoldierFSM",
	"CHECKBOX",
	["Disable soldier FSM", "Disables all functions upon mission-init"],
	_versionName,
	false
] call cba_settings_fnc_init;

[
	"SFSM_DebugType",
	"LIST",
	["Debugger", "Show debug-messages and 3D markers detailing what goes on under the hood."],
	_versionName,
	[
		["never", "curator", "always"],
		["Never", "Only when in Curator-mode", "Always"], 
		1
	]
] call cba_settings_fnc_init;


[
	"SFSM_noRubber",
	"CHECKBOX",
	["Prevent sprint-rubberbanding", "Rubberbanding units sometimes occurs on high-load missions, if checked this feature tries to mitigate it"],
	_versionName,
	true
] call cba_settings_fnc_init;

[
	"SFSM_BFFknowledgeType",
	"LIST",
	["Battle start side-knowledge", "Select wether or not both sides should know about eachother before battle starts"],
	_versionName,
	[
		["both sides", "one side"],
		["Both sides needs knowledge", "Start battle as soon as one unit spots another"], 
		1
	]
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


[
	"SFSM_globalUD",
	"CHECKBOX",
	["Global unit-data", "(experimental), Set this to false to reduce net-traffic. May affect client-players debug-mode."],
	_versionName,
	true
] call cba_settings_fnc_init;


#include "\soldierFSM\CBA_Options\Actions.sqf"
#include "\soldierFSM\CBA_Options\movement.sqf"
#include "\soldierFSM\CBA_Options\CQB.sqf"
#include "\soldierFSM\CBA_Options\players.sqf"
#include "\soldierFSM\CBA_Options\specialists.sqf"
#include "\soldierFSM\CBA_Options\vehicles.sqf"
#include "\soldierFSM\CBA_Options\overrun.sqf"
#include "\soldierFSM\CBA_Options\FIPO.sqf"
#include "\soldierFSM\CBA_Options\medical.sqf"
#include "\soldierFSM\functions\PR\customCBA.sqf"