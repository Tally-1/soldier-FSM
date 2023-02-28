params["_man", "_turret"];
_man assignAsGunner _turret;
[_man] orderGetIn true;
_man moveInGunner _turret;
private _eh = _turret addEventHandler ["GetOut", {_this spawn SFSM_fnc_onGetOutTurret}];
_turret setVariable ["SFSM_getOutEH", _eh];
true;