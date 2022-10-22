waitUntil { !isNil "SFSM_overrunDistance" };

[] call SFSM_fnc_3dDebug;
diag_log "**soldier FSM client loaded**";

if!(isServer)
then{[] call SFSM_fnc_logSettings};

true;