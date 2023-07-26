params ["_man", "_anim", "_thisEvent", "_thisEventHandler"];

_anim = toLowerANSI _anim;
private _wantedAnim = _man getVariable "SFSM_wantedExecAnim";
    
if(_wantedAnim isEqualTo _anim
|| {_wantedAnim in _anim})
then{
    private _execParams  = _man getVariable "SFSM_wantedExecParams";
    private _animHandle  = _man getVariable "SFSM_animHandle";
    private _returnValue = _execParams call SFSM_fnc_execFromArr;

    _man removeEventHandler [_thisEvent, _thisEventHandler];
    _man setVariable ["SFSM_wantedExecAnim",   nil];
    _man setVariable ["SFSM_wantedExecParams", nil];
    _man setVariable ["SFSM_animExecValue",    _returnValue];
    _man setVariable [_animHandle, true];
};