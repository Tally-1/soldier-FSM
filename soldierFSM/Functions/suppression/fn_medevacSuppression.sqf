params[
    ["_healer",  nil,[objNull]],
    ["_wounded", nil,[objNull]]
];
private _mainEnemy    = _wounded getVariable "SFSM_prevShooter";
private _suppressData = _this call SFSM_fnc_medevacSuppressionData;

// No hostiles found.
if(_suppressData isEqualTo [[],[]])exitWith{};

private _friendlies = _suppressData#0;
private _hostiles   = _suppressData#1 select {_x != _mainEnemy};

[
    _healer,
    _mainEnemy,
    _friendlies,
    _hostiles

] call SFSM_fnc_execMedevacSuppression;

true;