private _versionName = "DCO soldier FSM | Overrun";

[
	"SFSM_overRun",
	"CHECKBOX",
	["Enable overrun behaviour", "Allow overrun actions (surrender / flee / counter-attack)"],
	_versionName,
	true
] call CBA_fnc_addSetting;

[
	"SFSM_playerSquadOverRun",
	"CHECKBOX",
	["Overrun behaviour on player-squads", "Enable ai-soldiers in player-squads to be overrun"],
	_versionName,
	true
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;

[
	"SFSM_allowPanic",
	"CHECKBOX",
	["Allow Panic", "If checked soldiers will Panic under the right conditions."],
	_versionName,
	true
] call CBA_fnc_addSetting;


[
	"SFSM_allowSurrender",
	"CHECKBOX",
	["Allow Surrender", "If checked then soldiers will Surrender under the right conditions."],
	_versionName,
	true
] call CBA_fnc_addSetting;