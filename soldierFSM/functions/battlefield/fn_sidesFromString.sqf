private _string = _this;

// (typeName _string) call dbgmsg;
// _string call dbgmsg;
private _stringArr = _string splitString "[,]";
private _sides = [];

{
	if!(_x == "GUER")then{_sides pushBack (call compile _x)}
					 else{_sides pushBack independent};
} forEach _stringArr;

_sides