params["_array", "_splitCount"];
private _arrCount   = count _array;
private _elPrArr    = floor (_arrCount / _splitCount);
private _wholeCount = _elPrArr*_splitCount;
private _remaining  = _arrCount % _wholeCount;

private _splitArr = [];
private _index    = 0;
for "_i" from 0 to (_splitCount-1) do {
	private _newArr = _array select [_index, _elPrArr];
	_splitArr pushBack _newArr;
	_index = _index + _elPrArr;
};

if(_remaining > 0)then{
	private _newArr = _array select [_index, _remaining];
	_splitArr pushBack _newArr;
};

_splitArr;