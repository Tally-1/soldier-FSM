params[
    ["_man",        nil, [objNull]],
    ["_combatMode", nil,      [""]]
];
[_man] call SFSM_fnc_fixPos;

_man enableAI "FSM";
_man enableAI "AUTOTARGET";

[_man, "forcedMovement",      false] call SFSM_fnc_unitData;
[_man, "hasForcedMoveProned", false] call SFSM_fnc_unitData;

_man setAnimSpeedCoef 1;
if(SFSM_forceDodge)then{[_man, true] call Tcore_fnc_toggleAiMoveInhibitors};

_man setUnitCombatMode  _combatMode;