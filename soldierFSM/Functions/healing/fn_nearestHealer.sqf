params["_allHealers", "_woundedMan"];
private _healers = _allHealers select {[_x, _woundedMan] call SFSM_fnc_canBuddyHeal;};
private _nearest = ([_woundedMan, _allHealers] call Tcore_fnc_sortByDist)#0;
_nearest;