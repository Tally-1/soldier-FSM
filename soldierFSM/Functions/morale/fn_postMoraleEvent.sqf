params["_man", "_time", "_isHitEvent"];

for "_i" from 1 to 3 do {
	sleep (_time/3);

	[_man] call SFSM_fnc_updateMorale;
    
	if(_isHitEvent)exitWith{};
};


true;