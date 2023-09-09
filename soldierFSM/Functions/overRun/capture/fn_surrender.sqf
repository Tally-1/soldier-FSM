params["_man"];
["overrun_surrender",  [_man]] call CBA_fnc_localEvent;

private _side = side _man;
private _loadout = getUnitLoadout _man;
_man setVariable ["SFSM_loadout", _loadout];

// disable AI, schedule deletion, exclude autoStance
[[(name _man), " is surrendering"]] call dbgmsg;


_man setCaptive true;
_man disableAI "path";
_man setUnitPos "UP";
_man setVariable ["SFSM_surrendered", true, true];
_man setVariable ["SFSM_deleteTime", (round time)+300];
SFSM_cleanupObjs pushBackUnique _man;

[_man, "Surrendered"] call SFSM_fnc_setAction;

// private _drop = 
[_man, true] call SFSM_fnc_dropAllWeapons;
// waitUntil{sleep 0.1; scriptDone _drop;};

[_man, "Acts_JetsMarshallingEmergencyStop_in"] remoteExecCall ["switchMove",0];

[_man] call SFSM_fnc_panicAction;
[_man] call SFSM_fnc_captureAction;
[_man, _side] call SFSM_fnc_joinSurrenderGroup;

//Because some scripts might already be running the 
//Action call needs to be repeated (sometimes it is set to none)
[_man, "Surrendered"] call SFSM_fnc_setAction;

_man disableAI "all";

true;