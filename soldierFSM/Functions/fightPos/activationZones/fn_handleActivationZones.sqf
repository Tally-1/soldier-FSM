params[["_assignFipos", false]];

private _count = count SFSM_activationZones;
if(_count isEqualTo 0)exitWith{false;};

private _azFipos = [];

isNil{//Forced unscheduled execution.

//Men leaves outflanked, and inactive azFipos
{_x call [["getOut"]]} forEach SFSM_azFIPOs;

// private _startTime = time;

// The update will return fipos if the zone is populated.
{_azFipos append (_x call ["update"])} forEach SFSM_activationZones;

// private _timeSpent = round (time - _startTime);

// [["updated ", _count, " AZs in ", _timeSpent, " seconds."]] call dbgmsg;

// Just in case some of these has not been updated for >1 minute a check is done anyway.
private _filter     = {time - (_x get "last_fipo_handling") > 90 && {_x get "mode_code" isEqualTo 0}};
private _checkZones = SFSM_activationZones select _filter;
private _checkFipos = _checkZones apply {_x get "fipos";};

{_azFipos insert [0, _x, true];} forEach _checkFipos;

{_x set ["last_fipo_handling", time];} forEach _checkZones;

};

if(_assignFipos isEqualTo true 
&&{_azFipos isNotEqualTo []})
then{
	[["Assigning ", count _azFipos, " Az fipos."]] call dbgmsg;
	[_azFipos, true] call SFSM_fnc_fipoAssigner;
};

if(_assignFipos isEqualTo false)then{
	SFSM_activeAzFipos insert [0, _azFipos, true];
};

true;