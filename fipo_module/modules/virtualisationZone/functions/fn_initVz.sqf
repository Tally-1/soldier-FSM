if (is3DEN)   exitWith{}; // I may do a 3den function here later
if!(isServer) exitWith{};

_this spawn { 
waitUntil { time>5; };
_this call SFSM_fnc_initVirtualZone;
};