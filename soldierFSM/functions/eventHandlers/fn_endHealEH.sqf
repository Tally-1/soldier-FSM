private _actionText = "none";
params ["_man", "_actionText"];

_man addEventHandler ["HandleHeal", {
	params ["_unit", "_healer", "_isMedic"];
	[_unit, _thisEventHandler, _actionText] spawn SFSM_fnc_endSelfHeal; 
}];