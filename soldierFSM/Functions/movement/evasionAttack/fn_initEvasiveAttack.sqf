params[
    ["_man",    nil, [objNull]],
    ["_target", nil, [objNull]]
];

_man setAnimSpeedCoef SFSM_evasionAttackSpeed;
_man doTarget objNull;
_man setDir (_man getDir _target);
_man disableAI "MOVE";

[_man, "forcedMovement", true] call SFSM_fnc_unitData;
_man setVariable ["SFSM_myAttackTarget", _target];
_man setVariable ["SFSM_evasiveAttack",  true];

true;