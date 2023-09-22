private _fipos = [];

isNil{//forced unscheduled execution
private _sides        = _self get "sides_present";
private _newSides     = [];
private _units        = _self get "units";
private _status       = _self get "active";
private _newUnits     = _self call ["getUnits"];
private _activeNow    = (_newUnits isNotEqualTo []);


if(_units isEqualTo _newUnits)exitWith{};



_self set ["units", _newUnits];

{
	private _side = side _x;
	if(_side in (_self get "sides"))
	then{_newSides pushBackUnique _side};

}forEach _newUnits;

if(_activeNow)then{
    _fipos append (_self get "fipos");
    // [["Units moved in to AZ ", str (_self get "module")]] call dbgmsg;
}else{
	// [["Units moved out of AZ ", str (_self get "module")]] call dbgmsg;
};

if(_sides isEqualTo _newSides)exitWith{};

_self set  ["sides_present", _newSides];
// _self call ["onSidesChanged"];
["activation_sides_changed", _self] call CBA_fnc_localEvent;

if(_activeNow isEqualTo _status)exitWith{};

_self set ["active", _activeNow];
_self set ["last_activated", time];

};//Unscheduled execution ended...

_fipos;