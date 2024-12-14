params [
    ['_man',nil,[objNull]]
];
private _mg = [_man] call SFSM_fnc_isMachineGunner;
if(!_mg)exitWith{false};

private _available = [_man] call SFSM_fnc_availableAiSoldier;
if(!_available)exitWith{false};

true;