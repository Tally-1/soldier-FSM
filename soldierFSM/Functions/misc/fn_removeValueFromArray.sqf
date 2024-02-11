params[
    ["_value", nil],
    ["_array", nil, [[]]]
];

while {(_array find _value)> -1} do {
    private _index = _array find _value;
    _array deleteAt _index;
};

_array;