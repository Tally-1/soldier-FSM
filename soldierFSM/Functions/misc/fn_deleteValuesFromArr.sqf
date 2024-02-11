params[
	["_valuesToRemove", nil, [[]]],
	["_array",          nil, [[]]]
];

isNil{{_array = [_x, _array] call SFSM_fnc_removeValueFromArray} forEach _valuesToRemove;};

_array;