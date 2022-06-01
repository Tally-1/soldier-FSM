private _dodgeDir = selectRandom ["right", "left"];
params ["_man", "_enemy", "_dodgeDir"];
private _XX 			= (getPos _man) # 0;
private _YY 			= (getPos _man) # 1;
private _dir 			= _man getRelDir _enemy;
private _dirCorrection	= -90;

if(_dodgeDir == "right")then{_dirCorrection = 90};

private _newDir 	= (_dir + _dirCorrection);
private _dodgePos 	= [_XX, _YY, _newDir, SFSM_DodgeDistance] call SFSM_fnc_sinCosPos;


_dodgePos