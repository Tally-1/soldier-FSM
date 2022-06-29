private _distance = SFSM_DodgeDistance;
params['_man', '_enemy', '_distance'];
private _pos = getPos _man;
private _dir = _man getRelDir _enemy;
private _dirCorrection = selectRandom[90, -90];

_dir = [(_dir + _dirCorrection)] call Tcore_fnc_formatDir;

private _latPos = [_pos#0, _pos#1, _dir, _distance] call Tcore_fnc_sinCosPos;

_latPos