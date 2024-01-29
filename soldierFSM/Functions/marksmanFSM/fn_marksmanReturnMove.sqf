params["_marksman", "_destination"];

[_marksman, "action", "Returning to battle"] call SFSM_fnc_unitData;

[_marksman, _destination, 120] spawn SFSM_fnc_forcedMove;

_marksman doFollow (leader group _marksman);

[_marksman, "action", "none"] call SFSM_fnc_unitData;

true;