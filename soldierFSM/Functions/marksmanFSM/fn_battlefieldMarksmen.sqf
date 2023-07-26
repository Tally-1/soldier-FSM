params ["_battlefield"];
if!(SFSM_marksmanFSM)exitWith{};

"Initializing battlefield-sniper loop" call dbgmsg;

while {!isNil "_battleField"} do {
    private _scr = [_battlefield] spawn SFSM_fnc_activateMarksMen;
    waitUntil { sleep 0.1; scriptDone _scr;};
    sleep 10;
};

"battlefield-sniper loop ended" call dbgmsg;
true;