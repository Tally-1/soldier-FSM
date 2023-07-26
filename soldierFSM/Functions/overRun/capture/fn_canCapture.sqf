private _ignoreDistance = false;
private _ignoreState    = false;
params ["_captive", "_captor", "_ignoreDistance", "_ignoreState"];
if!([_captor, true] call SFSM_fnc_canRun)             exitWith{false;};
if!([_captor, _captive] call SFSM_fnc_hostile)        exitWith{false;};
if!(alive _captive)                                   exitWith{false;};
if([_captive, true] call SFSM_fnc_canRun)             exitWith{false;};

if (_ignoreDistance isEqualTo false
&&{_captor distance _captive > 5})  
exitWith{false;};

if (_ignoreState isEqualTo false
&&{[_captive] call SFSM_fnc_canBeCaptured isEqualTo false})  
exitWith{false;};


true;