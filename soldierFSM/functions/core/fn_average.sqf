params [
	"_numArr", 
	["_exactCalculation", false]
];

private _length = (Count _numArr);
if(_length isEqualTo 0)exitWith{0};

_numArr = _numArr select {typeName _x isEqualTo "SCALAR"};

_length = (Count _numArr);
if(_length isEqualTo 0)exitWith{0};

private _sum = 0;

{_sum = ((_sum) + _x);} forEach _numArr;

if(_sum isEqualTo 0)         exitWith {0};

Private _average = _sum / _length;

if(_exactCalculation) exitWith {_average;};

_average = round _average;


_average;