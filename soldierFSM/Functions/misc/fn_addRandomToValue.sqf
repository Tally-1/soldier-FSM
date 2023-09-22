params[
	["_value",       nil, [0]], 
	["_randomRange", nil, [0]],
	["_decimals",     -1, [0]]
];

if  (_randomRange > _value)
then{_randomRange = _value};

private _half         = _randomRange/2;
private _randomValue  = random _randomRange;
private _newVal       = (_value - _half)+_randomValue;

if(_decimals > 0)then{
	_decimals = round _decimals;
    _newVal = [_newVal, _decimals] call Tcore_fnc_decimals;
};

_newVal;