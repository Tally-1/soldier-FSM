params["_battlefield"];
if(isNil "_battlefield")exitWith{};

private _categorizedUnits  = [_battlefield] call SFSM_fnc_getWoundedAndHealers;
if(isNil "_categorizedUnits")exitWith{};

private _healers           = _categorizedUnits#0;
private _wounded           = _categorizedUnits#1;
private _incapacitated     = _categorizedUnits#2;

if(isNil "_incapacitated")exitWith{};

if(_healers isEqualTo [])exitWith{"Nobody is available for buddy-healing" call dbgmsg;};

if(_wounded isEqualTo []
&&{_incapacitated     isEqualTo []})exitWith{"Nobody is wounded and unable to heal" call dbgmsg;};


[[(count _wounded), " wounded and ", (count _incapacitated), " incapacitated on the field"]] call dbgmsg;

if(count _incapacitated > 0)exitWith{

	for "_i"from 0 to (count _incapacitated -1)do{
		private _woundedMan = _incapacitated#_i;
		private _pos = getPosATL _woundedMan;

		if(_pos#2 < 0)then{_woundedMan setPos [_pos#0, _pos#1, 0.2];};

		_healers = _healers select {[_x, _woundedMan] call SFSM_fnc_canBuddyHeal};
		private _reviver = (([_healers, [], {_woundedMan distance _x }, "ASCEND"] call BIS_fnc_sortBy))#0;
		
		if!(isNil "_reviver")then{
			[_reviver, _woundedMan] spawn SFSM_fnc_buddyRevive;
		};

		sleep 0.3;
	};
};


{
	[_x, _wounded, _incapacitated, _healers] call SFSM_fnc_initBuddyHeal;
	sleep 0.3;
	
} forEach _healers;

true;