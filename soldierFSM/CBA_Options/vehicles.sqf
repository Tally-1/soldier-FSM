private _versionName = "DCO soldier FSM | Vehicles";

[
	"SFSM_hijackVehicles",
	"LIST",
	["Hijack Vehicles", "Units will get in available vehicles as driver / gunner."],
	_versionName,
	[
		["always", "never", "action"],
		["Allow AI to hijack any vehicle", "Disable hijack behaviour", "Use action menu to reserve against hijacking"], 
		2
	]
] call cba_settings_fnc_init;



[
	"SFSM_hideFromVehicles",
	"CHECKBOX",
	["Hide from vehicles", "Units will run away / hide from vehicles they cannot hurt."],
	_versionName,
	true
] call cba_settings_fnc_init;



[
	"SFSM_hearingHide",
	"CHECKBOX",
	["Hide by hearing vehicle", "A Vehicle with engine ON is detected within hearing-distance"],
	_versionName,
	true
] call cba_settings_fnc_init;



[
	"SFSM_hearingDistance",
	"SLIDER",
	["Hearing distance", "Max distance a vehicle will be reacted to by hearing, (if in a urban area, half of this distance is used)."],
	_versionName,
	[
		0,   	//minimum 
		500, 	//max
		250,    //default
		0,	    //decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_hidingTimeOut",
	"SLIDER",
	["Hiding timeOut", "The max amount of time a unit will stay in a hiding-pos before returning to normal. (hiding is triggered by the presence of a enemy vehicle)"],
	_versionName,
	[
		5,   	//minimum 
		120, 	//max
		30,    //default
		0,	    //decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_turretLeaderDist",
	"SLIDER",
	["Turret to leader distance", "Max distance between a turret and a squad-leader. If within this range grunts from the squad will man the turret if available."],
	_versionName,
	[
		0,   	//minimum 
		100, 	//max
		40,    //default
		0,	    //decimals
		false
	],
	1
] call cba_settings_fnc_init;