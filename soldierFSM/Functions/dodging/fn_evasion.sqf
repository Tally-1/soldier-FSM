params["_man", "_enemy"];
if(SFSM_allowEvasion isEqualTo false)exitWith{[_man, "Evasion disabled"] call SFSM_fnc_evasionFail;};

private _evadeDir    = _this call SFSM_fnc_evadeDir;
private _evadeCenter = [_man, _evadeDir, SFSM_DodgeDistance]  call SFSM_fnc_sinCosPos2;
private _evadePos    = [_evadeCenter, SFSM_DodgeDistance] call SFSM_fnc_getLowestPos;

if(isNil "_evadePos")exitWith{
    [_man, "nil evadePos"] call SFSM_fnc_evasionFail;
};

[_man, "Evading fire"] call SFSM_fnc_setAction;
Private _onFinish = {
    private _man = _this#0;
    [_man, "none"] call SFSM_fnc_setAction;
    [_man] call SFSM_fnc_standardFlinch;
    true;
};

private _postAction = [[_man], false, _onFinish];

[
    _man, 
    _evadePos, 
    SFSM_DodgeTimer,
    2,
    2,
    _postAction
] spawn SFSM_fnc_forceMove2;

_evadePos;