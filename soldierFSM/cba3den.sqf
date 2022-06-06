
[
	"SFSM_FlinchTreshHold",
	"SLIDER",
	["Flinch TreshHold", "unit will not flinch if suppression is higher than this value"],
	"soldier FSM",
	[
		0.1,   	//minimum 
		2, 		//max
		0.5, 	//default
		2,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;





[
	"SFSM_FlinchCoolDown",
	"SLIDER",
	["Flinch CoolDown", "Minimum Time between each flinch-response"],
	"soldier FSM",
	[
		1,   	//minimum 
		120, 	//max
		5, 		//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;



[
	"SFSM_RpsDodgeTrigger",
	"SLIDER",
	["Dodge Trigger", "Continous Incoming bullets with no more than 1 second break, to trigger Dodging"],
	"soldier FSM",
	[
		2,   	//minimum 
		30, 	//max
		6, 		//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_DodgeCoolDown",
	"SLIDER",
	["Dodge CoolDown", "Time between each possible dodge-response"],
	"soldier FSM",
	[
		2,   	//minimum 
		30, 	//max
		6, 		//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_DodgeDistance",
	"SLIDER",
	["Dodge Distance", "How far the man will run when dodging"],
	"soldier FSM",
	[
		5,   	//minimum 
		200, 	//max
		20, 	//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_DodgeTimer",
	"SLIDER",
	["Dodge Timer", "Max time before ending a dodge."],
	"soldier FSM",
	[
		5,   	//minimum 
		60, 	//max
		10, 	//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;


[
	"SFSM_ProneTreshHold",
	"SLIDER",
	["Prone TreshHold", "unit will stay prone if suppression is higher than this value"],
	"soldier FSM",
	[
		0.1,   	//minimum 
		2, 		//max
		0.5, 	//default
		2,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;



[
	"SFSM_TaskCycleTimer",
	"SLIDER",
	["Task Cycle", "Time beteen each iteration of the Task-manager"],
	"soldier FSM",
	[
		8,   	//minimum 
		30, 	//max
		10, 	//default
		0,		//decimals
		false
	],
	1
] call cba_settings_fnc_init;



[
	"SFSM_forceDodge",
	"CHECKBOX",
	["Force Dodge", "Override the Vanilla FSM in order to force the unit to move when dodging"],
	"soldier FSM",
	true
] call cba_settings_fnc_init;

[
	"SFSM_Debugger",
	"CHECKBOX",
	["Debugger", "show debug-info, and 3D markers"],
	"soldier FSM",
	false
] call cba_settings_fnc_init;

[
	"SFSM_TestMode",
	"CHECKBOX",
	["Test Mode", "Use 'firedNear' eventHandler to simulate incoming fire (useful for testing)"],
	"soldier FSM",
	false
] call cba_settings_fnc_init;

