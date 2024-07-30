params [
    ["_man", nil, [objNull]]
];
private _eh = _man getVariable "FSM_moveCombatEh";
_man removeEventHandler ["Suppressed", _eh];
_man setVariable ["FSM_moveCombatEh",  nil];

true;