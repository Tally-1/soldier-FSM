params[
	["_startPos",   nil, [[],objNull]],
	["_direction",  nil,  [0]],
	["_iterations", 1,    [0]]
];

if(typeName _startPos isEqualTo "OBJECT")
then{
	if(isNil "_direction")
	then{_direction = getDirVisual _startPos;};
	_startPos = getPosATLVisual _startPos;
};

private _dir     = [_direction + (_self get "direction")] call Tcore_fnc_formatDir;
private _endPos  = [
	_startPos, 
	_dir,
	(_self get "distance") * _iterations

] call SFSM_fnc_sinCosPos2;


_endPos;