params[
	["_man",       nil, [objNull]], // The man throwing the smoke.
	["_targetDir", nil,       [0]] //  In what dir to throw the smoke.
];
private _smokes  = magazines _man select {"SmokeShell" in _x;};
private _grenade = _smokes#0;
if(isNil "_grenade")exitWith{false;};

if(!isNil "_targetDir")then{
	private _targetPos = [getPos _man, _targetDir, 5] call SFSM_fnc_sinCosPos2;
	[_man, _targetPos, 2, 0.1] spawn SFSM_fnc_forceLookAtPos;
	sleep 0.5
};

private _muzzle = [_grenade, "Muzzle"] joinString "";
[_man, "Deploying smoke"] spawn SFSM_fnc_flashAction;
_man forceWeaponFire [_muzzle, _muzzle];

sleep 1.5;

true;