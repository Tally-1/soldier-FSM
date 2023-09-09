params [
    "_man", 
    ["_ignoreLegs",      false],
    ["_ignoreFipo",      false],
    ["_ignorePath",      false],
    ["_includeExcluded", false]
];

private _canRun = true;
isNil{//Forced unscheduled execution
    if!([_man] call SFSM_fnc_isRealMan)          exitWith{_canRun = false;};
    if (_man call SFSM_fnc_inVehicle)            exitWith{_canRun = false;};
    if ([_man] call SFSM_fnc_isUncon)            exitWith{_canRun = false;};
    if (captive _man)                            exitWith{_canRun = false;};

    if(_ignoreFipo isEqualTo false
    &&{[_man, "inFipo"] call SFSM_fnc_unitData})
    exitWith{_canRun = false;};

    if(_includeExcluded isEqualTo false
    &&{_man getVariable ["SFSM_Excluded", false]})
    exitWith{_canRun = false;};

    if(_ignorePath                               isEqualTo false
    &&{(_man checkAIFeature "PATH")              isEqualTo false
    &&{([_man, "inFipo"] call SFSM_fnc_unitData) isEqualTo false}})
    exitWith{_canRun = false;};

    if (_ignoreLegs)exitWith{true;};

    private _legDamage = getAllHitPointsDamage _man#2#10;
    if(_legDamage > 0.4)exitWith{_canRun = false;};
};

_canRun;