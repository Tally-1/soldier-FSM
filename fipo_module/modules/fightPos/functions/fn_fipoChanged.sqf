params ["_fipo"];
// [] call FIPO_fnc_removeGarbage;
private _show = _fipo getVariable "showIndicators";
if!(_show)exitWith{
	[_fipo] call FIPO_fnc_deleteIndicators;
};
// systemChat "FIPO changed";
[_fipo] call FIPO_fnc_spawnIndicators;
[_fipo] call FIPO_fnc_updateIndicators;

_indicators;