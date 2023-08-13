params["_man", "_enemy"];
if(SFSM_allowEvasion isEqualTo false)exitWith{[_man, "Evasion disabled"] call SFSM_fnc_evasionFail;};

private _evadeDir           = _this call SFSM_fnc_evadeDir;
private _evadeCenter        = [_man, _evadeDir, SFSM_DodgeDistance]  call SFSM_fnc_sinCosPos2;
private _availablePositions = [_evadeCenter, SFSM_DodgeDistance, 20] call Tcore_fnc_availablePositions;

if(_availablePositions isEqualTo [])exitWith{[_man, "No evadePos"] call SFSM_fnc_evasionFail;};

private _evadePos = [_evadeCenter, _availablePositions] call SFSM_fnc_getNearest;

if(isNil "_evadePos")exitWith{
    [_man, "nil evadePos"] call SFSM_fnc_evasionFail;
};

[_man, "Evading fire"] call SFSM_fnc_setAction;

private _postAction = [[_man, "none"], false, SFSM_fnc_setAction];

[
    _man, 
    _evadePos, 
    SFSM_DodgeTimer,
    2,
    2,
    _postAction
] spawn SFSM_fnc_forceMove2;

_evadePos;