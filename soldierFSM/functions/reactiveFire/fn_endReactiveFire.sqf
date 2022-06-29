params ["_man"];
private _timer = time + SFSM_reactFireCoolDown;
_man doWatch  objNull;
[_man, "reactFireTimer", _timer]	call SFSM_fnc_unitData;
[_man, "action", "none"]			call SFSM_fnc_unitData;
true;