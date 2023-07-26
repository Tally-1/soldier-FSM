params ["_marksman", "_target"];
if([_marksman, _target] call SFSM_fnc_huntEnded)          exitWith{true};
if([_marksman, _target, 0.8] call SFSM_fnc_targetVisible) exitWith{true};
false;