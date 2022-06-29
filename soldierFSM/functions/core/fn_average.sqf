
_exactCalculation = false;
params ["_Arr", "_exactCalculation"];
if(count _Arr == 0)exitWith{0};
Private _NewArr = [];

{If(TypeName _X == "SCALAR")then{_NewArr Pushback _X}}ForEach _Arr;

_Arr = _NewArr;

if(count _Arr == 0)exitWith{0};

private _Length = (Count _Arr);
private _sum = 0;

for "_i" from 0 to (_Length - 1) do {_sum = ((_sum) + ((_Arr) select _i))};

if(_sum == 0)exitWith{0};

Private _Average = (round (_sum / _Length));
if (_exactCalculation) then{_Average = (_sum / _Length)};

_Average 