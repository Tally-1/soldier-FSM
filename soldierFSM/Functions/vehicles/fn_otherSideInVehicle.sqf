params["_vehicle", "_man"];

private _currentUnits = _vehicle getVariable ["targetedBy", []];

if(_currentUnits isEqualTo [])exitWith{false;};

private _otherSidePresent = false;

{
	if((side _x) != (side _man))
	exitWith{_otherSidePresent = true;};
	
} forEach _currentUnits;

_otherSidePresent;