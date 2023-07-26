params["_edgePositions", "_color"];
private _outerPositions = _edgePositions select [1, 11];
private _startPos       = _edgePositions#0;
        _startPos       = [_startPos#0,_startPos#1, (_startPos#2) + 1.5];
private _lines          = [];
private _c              = 2;
{
	private _line = [_startPos, _x, _color];
	_lines pushBack _line;

	if(_c < 12)then{
		_line = [_x, _edgePositions#_c, _color];
		_lines pushBack _line;
	};
	_c=_c+1;
	
} forEach _outerPositions;

_lines;