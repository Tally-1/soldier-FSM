params [
    ["_man", nil, [objNull]]
];
private _eh = _man getVariable "FSM_moveCombatEh";
_man setVariable ["FSM_moveCombatEh",  nil];

if(isNil "_eh")exitWith{false};
_man removeEventHandler ["Suppressed", _eh];

true;