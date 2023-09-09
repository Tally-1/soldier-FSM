params["_marksman", "_destination"];

[_marksman, "action", "Returning to battle"] call SFSM_fnc_unitData;

// private _move = 
[_marksman, _destination, 120] spawn SFSM_fnc_forceMove2;
// waitUntil { sleep 1; scriptDone _move };

_marksman doFollow (leader group _marksman);

[_marksman, "action", "none"] call SFSM_fnc_unitData;

true;