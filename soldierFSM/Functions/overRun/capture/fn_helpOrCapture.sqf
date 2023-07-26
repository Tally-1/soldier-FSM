params[
    "_man", 
    "_units", 
    "_excluded"
];

_units = [_man, _units, _excluded, 70] call SFSM_fnc_availEnemyFriendDist;
private _allies       = _units#0;
private _availEnemies = _units#1;
private _enemies      = ([_man] call SFSM_fnc_nearEnemies);
private _surrendered  = _man getVariable ["SFSM_surrendered", false];
private _panic        = _man getVariable ["SFSM_panic", false];

// hint str _availEnemies;

// Surrendered but there are no longer any enemies nearby.
if(_enemies isEqualTo []
&&{_surrendered})exitWith{[_man] spawn SFSM_fnc_calmPanicked;};

if(_enemies isEqualTo    []
&&{_allies  isNotEqualTo []
&&{_panic}})exitWith{
    private _nearestAlly = [_man, _allies]call SFSM_fnc_getNearest;
    [_nearestAlly, _man] call SFSM_fnc_initAiRescue;
    _nearestAlly;
};

//Surrendered / panicked / unconscious & no near friends but there is available enemies near
if(_allies       isEqualTo    []
&&{_availEnemies isNotEqualTo []
&&{(_surrendered
|| {_panic
|| {[_man] call SFSM_fnc_isUncon
}})}})exitWith{
    private _nearestEnemy = [_man, _availEnemies]call SFSM_fnc_getNearest;
    [_man, _nearestEnemy] call SFSM_fnc_initCapture;
    [_nearestEnemy, "init capture"] spawn SFSM_fnc_flashAction;
    _nearestEnemy;
};

objNull;