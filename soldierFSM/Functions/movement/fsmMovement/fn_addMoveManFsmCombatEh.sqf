params [
    ["_man", nil, [objNull]]
];
private _eh = 
_man addEventHandler ["Suppressed", {
	params ["_man", "_distance", "_shooter"];
	private _timePassed = time - (_man getVariable "FSM_moveStart");
	if(_timePassed < 3)exitWith{};

	if!([_man, _shooter] call SFSM_fnc_validFsmMoveTarget)exitWith{};
	_man enableAI "AUTOTARGET";
}];

_man setVariable ["FSM_moveCombatEh", _eh];

true;