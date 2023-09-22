params ["_man"];
private _explosives = magazines _man select {[_x] call SFSM_fnc_isExplosiveMag;};
if(_explosives isEqualTo [])exitWith{};

private _biggest = ([_explosives, [], { [_x] call SFSM_fnc_getMagSplashRange;}, "DESCEND"] call BIS_fnc_sortBy)#0;
if(isNil "_biggest")exitWith{};

_biggest;