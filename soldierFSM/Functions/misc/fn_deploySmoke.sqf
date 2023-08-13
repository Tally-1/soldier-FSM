params["_man"];
private _smokes   = magazines _man select {"SmokeShell" in _x;};
private _grenade  = _smokes#0;
if(isNil "_grenade")exitWith{false;};

private _muzzle = [_grenade, "Muzzle"] joinString "";

[_man, "Deploying smoke"] spawn SFSM_fnc_flashAction;
_man forceWeaponFire [_muzzle, _muzzle];

true;