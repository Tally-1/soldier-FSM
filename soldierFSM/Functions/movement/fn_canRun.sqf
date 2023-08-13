private _ignoreLegs      = false;
private _ignoreFipo      = false;
private _ignorePath      = false;
private _includeExcluded = false;
params [
    "_man", 
    "_ignoreLegs",
    "_ignoreFipo",
    "_ignorePath",
    "_includeExcluded"
];
if!([_man] call SFSM_fnc_isRealMan)          exitWith{false;};
if (_man call SFSM_fnc_inVehicle)            exitWith{false;};
if ([_man] call SFSM_fnc_isUncon)            exitWith{false;};
if (captive _man)                            exitWith{false;};

if(_ignoreFipo isEqualTo false
&&{[_man, "inFipo"] call SFSM_fnc_unitData})
exitWith{false;};

if(_includeExcluded isEqualTo false
&&{_man getVariable ["SFSM_Excluded", false]})
exitWith{false;};

if(_ignorePath                               isEqualTo false
&&{(_man checkAIFeature "PATH")              isEqualTo false
&&{([_man, "inFipo"] call SFSM_fnc_unitData) isEqualTo false}})
exitWith{false;};

if (_ignoreLegs)exitWith{true;};

private _legDamage = getAllHitPointsDamage _man#2#10;
if(_legDamage > 0.4)exitWith{false;};

true;