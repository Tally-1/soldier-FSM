private _maxDecimals = 0;
params ["_number", "_maxDecimals"];
// Old method
// Who fixed this?
/*
private _multiPlier = 0;
if(_maxDecimals == 1)then{_multiPlier = 10};
if(_maxDecimals == 2)then{_multiPlier = 100};
if(_maxDecimals == 3)then{_multiPlier = 1000};
if(_maxDecimals == 4)then{_multiPlier = 10000};
if(_maxDecimals >  4)then{_multiPlier = 100000};

if(_multiPlier == 0)exitWith{round(_number)};

_number = round (_number * _multiPlier);
_number = (_number / _multiPlier);
*/
// New method 
parseNumber (_number toFixed _maxDecimals);
