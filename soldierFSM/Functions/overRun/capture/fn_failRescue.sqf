private _isRescue = false;
params ["_captive", "_captor", "_isRescue"];
private _nextAction   = "none";
private _flashAction  = "Capture failed";

if(_isRescue)then{
    private _flashAction  = "Rescue failed";
};

if(_captive getVariable ["SFSM_surrendered", false]
&&{!([_captive] call SFSM_fnc_isUnCon)})then{
    _nextAction   = "Surrendered";
};

if(_captive getVariable ["SFSM_panic", false]
&&{!([_captive] call SFSM_fnc_isUnCon)})then{
    _nextAction   = "!PANIC!";
};

// [_captive, _nextAction] call SFSM_fnc_setAction;
[_captor,  "none"] call SFSM_fnc_setAction;
[_captive, _flashAction] spawn SFSM_fnc_flashAction;
[_captor,  _flashAction] spawn SFSM_fnc_flashAction;