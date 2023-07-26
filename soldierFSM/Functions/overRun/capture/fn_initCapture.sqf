params ["_captive", "_captor"];

private _capPos = getPosATLVisual _captive;
[
    _captor,
    _capPos,
    60,
    2,
    2,
    [[_captive, _captor], true, SFSM_fnc_aiCaptureMan]
] spawn SFSM_fnc_forceMove2;

[_captor, "Capturing enemy"] call SFSM_fnc_setAction;
[_captive, "Being captured"] call SFSM_fnc_setAction;

true;