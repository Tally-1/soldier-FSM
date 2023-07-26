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
	"SFSM_playerSquadFipo",
	"CHECKBOX",
	["Player squad fighting position", "enable ai-soldiers in player-squads to get into fipos "],
	_versionName,
	false
] call cba_settings_fnc_init;