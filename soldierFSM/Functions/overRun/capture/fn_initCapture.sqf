params ["_captive", "_captor"];
private _conditionParams = [_captive, _captor, true];
private _condition = [_conditionParams, SFSM_fnc_canCapture];


private _capPos = getPosATLVisual _captive;
[
    _captor,
    _capPos,
    nil,
    3,
    _condition,
    [[_captive, _captor], true, SFSM_fnc_aiCaptureMan]
] spawn SFSM_fnc_forcedMove;

[_captor, "Capturing enemy"] call SFSM_fnc_setAction;
[_captive, "Being captured", 10] spawn SFSM_fnc_flashAction;

true;