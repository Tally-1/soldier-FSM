params["_posArr"];
if(count _posArr == 0)exitWith{[]};
if(count _posArr < 2)exitWith{_posArr#0};

Private _Xarr 			= [];
Private _Yarr 			= [];

{
	_Xarr pushback _x#0;
	_Yarr pushback _x#1;
} forEach _posArr;

private _XX = [_Xarr] call Tcore_fnc_average;
private _YY = [_Yarr] call Tcore_fnc_average;

[_XX, _YY, 0];