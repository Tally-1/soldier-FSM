params ["_man"];

_man setVariable ["SFSM_captive", true];
_man playMoveNow "Acts_executionvictim_Loop";
[_man, "Captured"] call SFSM_fnc_setAction;

if([_man] call SFSM_fnc_isPlayer) exitWith{};

_man disableAI "PATH";
_man disableAI "MOVE";
_man disableAI "FSM";
_man disableAI "AUTOTARGET";
_man disableAI "AUTOCOMBAT";
_man disableAI "CHECKVISIBLE";
_man disableAI "COVER";
_man disableAI "SUPPRESSION";
_man disableAI "TARGET";
_man disableAI "WEAPONAIM";

if(SFSM_captiveAutoDeath isEqualTo -1) exitWith{};

private _captives = SFSM_captivesToDie apply {_x#0;};
if(_man in _captives)exitwith{};

SFSM_captivesToDie pushBackUnique [_man, round time];


true;