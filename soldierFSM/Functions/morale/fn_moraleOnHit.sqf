params ["_victim", "_source", "_damage", "_instigator"];
private _shooter  = _man getVariable ["SFSM_prevShooter", objNull];

[_victim,     "hit-by-enemy"] call SFSM_fnc_moraleEvent;
[_source,     "enemy-hit"]    call SFSM_fnc_moraleEvent;
[_instigator, "enemy-hit"]    call SFSM_fnc_moraleEvent;

true;