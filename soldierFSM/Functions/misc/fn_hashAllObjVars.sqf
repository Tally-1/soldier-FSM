params[
	["_object", nil, [objNull]]
];
private _dataArr = []; 
{
	private _key   = _X;
	private _value = _object getVariable _x;
	private _data  = [_key, _value];
	private _noCBA = !("cba" in _key);
	private _noACE = !("ace" in _key);
	
	if(_noCBA
	&&{_noACE})
	then{_dataArr pushBack _data};

} forEach allVariables _object;

private _hashMap = createHashMapObject [_dataArr];

_hashMap set ["asl_pos", getPosASLVisual _object];
_hashMap set ["dir",     getDirVisual    _object];

_hashMap;