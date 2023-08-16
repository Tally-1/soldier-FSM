private _versionName = "DCO soldier FSM | Fighting Positions (FIPO)";

[
	"SFSM_fipoGetInDistance",
	"SLIDER",
	["Fighting position distance", "Max distance between fighting position and a squad-leader. If within this range grunts from the squad will move in to said fighting position"],
	_versionName,
	[
		30,   	//minimum 
		120, 	//max
		50,     //default
		0,	    //decimals
		false
	]
] call cba_settings_fnc_init;



[
	"SFSM_allowFipoTeleport",
	"CHECKBOX",
	["Snap into fighting position", "Makes it easier for ai to get into position by teleporting the last 10m. (only happens when outside the range defined below)"],
	_versionName,
	true
] call cba_settings_fnc_init;



[
	"SFSM_playerSpotTeleportDist",
	"SLIDER",
	["FIPO-snap distance to players", "If an ai is within this range and is visible to the nearest player then he will not snap into the fighting position, but walk all the way."],
	_versionName,
	[
		40,   	//minimum 
		500, 	//max
		200,     //default
		0,	    //decimals
		false
	]
] call cba_settings_fnc_init;

[
	"SFSM_fipoKnockOutTime",
	"SLIDER",
	["Knock Out Time", "How long A FIPO is unusable after a man has been killed / knocked out while in it. (The FIPO needs to have the ''Disable if FUBAR option activated'')"],
	_versionName,
	[
		10,   	//minimum 
		300, 	//max
		120,    //default
		0,	    //decimals
		false
	]
] call cba_settings_fnc_init;


[
	"SFSM_playerSquadFipo",
	"CHECKBOX",
	["Player squad fighting position", "enable ai-soldiers in player-squads to get into fipos "],
	_versionName,
	false
] call cba_settings_fnc_init;


[
    "FIPO_idleAnimations",
    "EDITBOX",
    ["Idle animations", "A random animation from this list is played while the soldier is idle. When editing make sure commas and quotation-signs are written correctly."],
    _versionName,
    "['Acts_Executioner_Squat', 'Acts_AidlPercMstpSlowWrflDnon_pissing', 'Acts_AidlPercMstpSlowWrflDnon_warmup03', 'Acts_AidlPercMstpSnonWnonDnon_warmup_7_loop', 'Acts_AidlPercMstpSnonWnonDnon_warmup_6_loop']"
] call cba_settings_fnc_init;