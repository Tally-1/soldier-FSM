params["_man", "_time", "_isHitEvent"];
// if(_isHitEvent)exitWith{};

sleep (_time/2);
isNil{[_man] call SFSM_fnc_updateMorale;};

true;