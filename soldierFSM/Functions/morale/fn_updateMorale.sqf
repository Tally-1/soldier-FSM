params["_man", ["_storeData", SFSM_storeMoraleData]];
private _baseMorale    = [_man, _storeData] call SFSM_fnc_baseMorale;
private _allEvents     = [_man, "moraleEvents"] call SFSM_fnc_unitData;
private _endResult     = [_baseMorale, _allEvents, _storeData] call SFSM_fnc_moraleFinal;

_endResult params ["_finalMorale", "_activeEvents"];

// store the new data into the unitData hashmap, and update probability of fleeing for the unit.
[_man, "moraleEventsActive", _activeEvents] call SFSM_fnc_unitData;
[_man, "moraleEvents",       _allEvents]    call SFSM_fnc_unitData;
[_man, "baseMorale",         _baseMorale]   call SFSM_fnc_unitData;
[_man, "morale",             _finalMorale]  call SFSM_fnc_unitData;
[_man]                                      call SFSM_fnc_updateFleeCoef;

_finalMorale;