params ["_man"];
private _eh =
_man addEventHandler ["Hit", { 
    _this append [_thisEvent, _thisEventHandler];
    _this spawn {
    sleep 0.02;
    params ["_man", "_killer", "_instigator", "_useEffects", "_thisEvent", "_thisEventHandler"];
    if([_man] call SFSM_fnc_isUncon)then{
    _man setDamage 1;
    [_man] call SFSM_fnc_endCapture;
}}}];

_man setVariable ["SFSM_captureHitEh", _eh];

true;