params[
	["_man", nil, [objNull]]
];


_man doTarget objNull;
_man disableAI "FSM";
_man disableAI "AUTOTARGET";
_man setAnimSpeedCoef SFSM_sprintSpeed;

[_man] call SFSM_fnc_fixPos;
[_man, "forcedMovement", true] call SFSM_fnc_unitData;
[_man, "hasForcedMoveProned", false] call SFSM_fnc_unitData;

if(SFSM_forceDodge)then{[_man, false] call Tcore_fnc_toggleAiMoveInhibitors};

true;