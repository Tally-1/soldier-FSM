_this spawn{ 
params["_module"];
private _targetClass = _module getVariable "TMOD_syncTo";

// The purpose here is to prioritize the implementation of traits by specificity.
// Eg. Individual settings will override group-settings.
// There are better ways of doing this in terms of performance, but I dont care since
// this function is only run once at the start of the mission.

// if(_targetClass isEqualTo "side")    then{sleep = 0};
if(_targetClass isEqualTo "faction") then{sleep 2;};
if(_targetClass isEqualTo "group")   then{sleep 4;};
if(_targetClass isEqualTo "man")     then{sleep 6;};


private _targets = [_module] call TMOD_fnc_getModuleTargets;
{
    if(_x isKindOf "caManBase")then{
        [_module, _x] spawn TMOD_fnc_applyModuleTraits;
    };
} forEach _targets;
};
