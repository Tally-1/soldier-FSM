private _versionName = "DCO soldier FSM | Player Options";

[
	"SFSM_autoStanceEnabled",
	"CHECKBOX",
	["Enable auto-stance", "Enable auto-stance for playerGroups, ai will normalize stance after going prone"],
	_versionName,
	true
] call CBA_fnc_addSetting;

[
	"SFSM_autoStanceAction",
	"CHECKBOX",
	["Show auto-stance Action", "Add action to toggle Autostance. Only applies to squad-leaders with Ai members in their squad."],
	_versionName,
	true
] call CBA_fnc_addSetting;

[
	"SFSM_buddyRearm",
	"CHECKBOX",
	["Show buddy-rearm Action", "When ammo for primary weapon is low, an action is added to allowing the player to call for ammo from his squad-members"],
	_versionName,
	true
] call CBA_fnc_addSetting;

[
	"SFSM_buddyHeal",
	"CHECKBOX",
	["Show buddy-heal Action", "When health is low, and the player has no medkit, an action is added allowing the player to call for medical-help from his squad-members"],
	_versionName,
	true
] call CBA_fnc_addSetting;