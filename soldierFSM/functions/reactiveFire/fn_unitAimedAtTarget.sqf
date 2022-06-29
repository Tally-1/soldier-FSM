private _vectorCalc 	= false;
private _maxDeviation 	= 3;
params["_shooter", "_target", "_maxDeviation", "_vectorCalc"];
private _dir 		= [_shooter] call SFSM_fnc_unitWeaponDir;
private _targetDir 	= (_shooter getRelDir _target) + _dir;

private _trueAim = [_dir, _targetDir] call Tcore_fnc_inDirRange; 

_trueAim