private _dist = 2;
params[
	"_man", 
	"_dir",
	"_dist"	
];

private _pos    = aimPos _man;
private _vPos = [_man, _dir, _dist] call SFSM_fnc_relAimPos;
private _objsInPath = lineIntersectsObjs [_pos, _vPos, _man, objNull, true, 2];

_objsInPath;