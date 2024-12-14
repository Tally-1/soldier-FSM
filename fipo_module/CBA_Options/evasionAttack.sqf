private _versionName = "DCO soldier FSM | Evasion Attack";
[
	"SFSM_allowEvasionAttack",
	"CHECKBOX",
	["Allow evasive attack", "When rushing an enemy at close range the AI will sometimes do a evasive manouver before firing, such as Zig-Zag or a quick flank."],
	_versionName,
	true
	
] call CBA_fnc_addSetting;

[
	"SFSM_evasionAttackSpeed",
	"SLIDER",
	[
		"Evasive attack speed", 
		"Speed coef for evasive attacks. Faster speeds makes the AI harder to hit, slower speeds makes him more accurate when moving and shooting."
	],
	_versionName,
	[
		0.7,   	//minimum 
		2,    //max
		1.2, 	//default
		1,		//decimals
		false
	],
	1
	
] call CBA_fnc_addSetting;


[
	"SFSM_evasionAttackCoolDown",
	"SLIDER",
	[
		"Evasive attack Cool-down", 
		"How long between each time a soldier can execute an evasive attack"
	],
	_versionName,
	[
		0,   	//minimum 
		120,    //max
		10, 	//default
		0,		//decimals
		false
	],
	1
	
] call CBA_fnc_addSetting;


[
	"SFSM_EA_ZigZag",
	"CHECKBOX",
	["Zig-Zag sidestep", "Enable Zig-Zag sidestep evasive attack."],
	_versionName,
	true
	
] call CBA_fnc_addSetting;

[
	"SFSM_EA_feintPushRight",
	"CHECKBOX",
	["Feint left, push right", "Enable Evade left --> push right evasive attack."],
	_versionName,
	true
	
] call CBA_fnc_addSetting;


[
	"SFSM_EA_feintPushLeft",
	"CHECKBOX",
	["Feint right, push left", "Enable Evade right --> push left evasive attack."],
	_versionName,
	true
	
] call CBA_fnc_addSetting;

[
	"SFSM_EA_flankRight",
	"CHECKBOX",
	["Flank Right", "Enable flank right evasive attack."],
	_versionName,
	true
	
] call CBA_fnc_addSetting;

[
	"SFSM_EA_flankLeft",
	"CHECKBOX",
	["Flank Left", "Enable flank left evasive attack."],
	_versionName,
	true
	
] call CBA_fnc_addSetting;