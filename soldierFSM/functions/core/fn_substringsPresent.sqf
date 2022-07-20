params["_string", "_subStrings"];
private _present = false;

{
	if(_x in _string)exitWith{_present = true};
} forEach _subStrings;

_present