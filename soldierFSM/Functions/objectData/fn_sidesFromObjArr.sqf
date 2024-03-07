private _defaultSides = [east,west,independent];
params[
    ["_objArr", nil,           [[]]],
	["_sides",  _defaultSides, [[]]]
];
private _sidesPresent = [];
{
	private _side = side _x;
	if  (_side in _sides)
	then{_sidesPresent pushBackUnique _side};
	
} forEach _objArr;

_sidesPresent;