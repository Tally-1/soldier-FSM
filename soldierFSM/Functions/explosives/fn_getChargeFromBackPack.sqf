params["_man"];
private _explosives = [_man] call SFSM_fnc_carriedExplosives;
if(count _explosives <1)exitWith{[]};
_explosives sort false;
private _explosive = _explosives#0;
private _charge = [_explosive] call SFSM_fnc_formatExplosiveName;

[_explosive, _charge];