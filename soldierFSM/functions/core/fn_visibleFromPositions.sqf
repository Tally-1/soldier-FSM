params ["_fromPos", "_toPosArr", "_ignoreObj"];

private _visibility = [];
private _startPos = AGLToASL _fromPos;

if(count _toPosArr < 1)exitWith{/*"no entries found in _toPosArr (visibleFromPositions)" call Tcore_fnc_debugMessage;*/ false}; 

{
	private _targetPos = AGLToASL [_x # 0, _x # 1, 2];
	private _targetObj = (nearestObjects [[_targetPos#0,_targetPos#1], ["Land"], 3]) # 0;

	if(isNil "_targetObj")then{_targetObj = objNull};
	if(isNil "_ignoreObj")then{_ignoreObj = objNull};

	private _v = ([_ignoreObj, "VIEW", _targetObj] checkVisibility [_startPos, _targetPos]);
	_visibility pushBack _v;
} forEach _toPosArr;

private _coef = selectMax  _visibility;

if(isNil "_coef")exitWith{/*"no entries found in vis arr (visibleFromPositions)" call Tcore_fnc_debugMessage;*/ false};

private _visible = _coef > 0.1;

_visible