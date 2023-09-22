params["_man"];
private _morale        = [_man, "morale"]             call SFSM_fnc_unitData;
private _lastPanCheck  = [_man, "lastFipoPanicCheck"] call SFSM_fnc_unitData;
private _panicCount    = [_man, "fipoPanicCount"]     call SFSM_fnc_unitData;
private _timeSinceLast = time - _lastPanCheck;

if(_morale > 0)         exitWith {false;};
if(_timeSinceLast < 10) exitWith {false;};

[_man, "lastFipoPanicCheck", time] call SFSM_fnc_unitData;

private _noAmmo     = [_man] call SFSM_fnc_hasAmmoForWeapon isEqualTo false;
private _injured    = [_man, 0.5] call SFSM_fnc_manIsInjured;
private _panic      = (_noAmmo || _injured);
private _addToCount = _panic && {_panicCount < 2};

if(_addToCount)exitWith{ 
	[_man, "fipoPanicCount", (_panicCount+1)] call SFSM_fnc_unitData;
    false;
};

if(_panic isEqualTo false)exitWith{false;};

[_man, "fipoPanicCount", 0] call SFSM_fnc_unitData;
[_man] call SFSM_fnc_getOutFipo;
[_man] spawn SFSM_fnc_panic;

[["Man panicked while in FIPO..."], 2] call dbgmsg;

true;