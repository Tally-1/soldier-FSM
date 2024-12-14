private _versionName = "DCO soldier FSM | Specialists";

[
	"SFSM_disableSpecialists",
	"LIST",
	["Disable Specialists", "This will keep AT and MG's from doing their thing at the start of an engagement. (they will still engage if combat mode is set to engage at will)"],
	_versionName,
	[
		["all", "player-squads", "none"],
		["Disable for all squads", "Disable for player squads only", "No squads disabled"], 
		1
	]
] call CBA_fnc_addSetting;


[
	"SFSM_AtSpecHuntVehicles",
	"CHECKBOX",
	["AT hunt vehicles", "Units with launchers will target enemy vehicles instead of hiding."],
	_versionName,
	true
] call CBA_fnc_addSetting;


[
	"SFSM_mgSuppression",
	"CHECKBOX",
	["MG's suppress enemy", "Enables mahcinegun suppression at the start of an engagement"],
	_versionName,
	true
] call CBA_fnc_addSetting;


[
	"SFSM_specRegroupDist",
	"SLIDER",
	["Regroup distance", "Distance to leader for specialists to regroup. An AT / MG will abort their hunting / suppresion and be forced back into formation if they are further away from the leader than this."],
	_versionName,
	[
		70,   	//minimum 
		500, 	//max
		150,    //default
		0,	    //decimals
		false
	],
	1
] call CBA_fnc_addSetting;


[
	"SFSM_marksmanFSM",
	"CHECKBOX",
	["Marksman FSM", "Enables snipers / marksmen with long-range scopes to hunt for High Value Targets on the battlefield."],
	_versionName,
	true
] call CBA_fnc_addSetting;

[
	"SFSM_maxHuntTime",
	"SLIDER",
	["Marksman Hunt Time", "The maximum amount of time a marksman will hunt for his target before giving up."],
	_versionName,
	[
		120,   	//minimum 
		900, 	//max
		300,    //default
		0,	    //decimals
		false
	],
	1
] call CBA_fnc_addSetting;

[
	"SFSM_huntCooldown",
	"SLIDER",
	["Marksman cooldown time", "How long a marksman will wait before starting a new hunt after finishing the previous one."],
	_versionName,
	[
		0,    //minimum 
		300, //max
		10, //default
		0, //decimals
		false
	],
	1
] call CBA_fnc_addSetting;

[
	"SFSM_maxMgs",
	"SLIDER",
	["Max machine Gunners", "The maximum amount of machine-gunners in a squad, if the number is less than this the soldiers in the squad will look for machineguns on the battleField and pick them up."],
	_versionName,
	[
		0,   //minimum 
		16, //max
		4, //default
		0, //decimals
		false
	],
	1
] call CBA_fnc_addSetting;

[
	"SFSM_maxAts",
	"SLIDER",
	["Max AT Soldiers", "The maximum amount of Anti Tank soldiers in a squad, if the number is less than this the soldiers in the squad will look for launchers on the battleField and pick them up."],
	_versionName,
	[
		0,   //minimum 
		16, //max
		4, //default
		0, //decimals
		false
	],
	1
] call CBA_fnc_addSetting;