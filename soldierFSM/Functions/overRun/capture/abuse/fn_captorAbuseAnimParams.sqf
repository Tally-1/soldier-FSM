params["_captive", "_captor", "_forceExecution"];
private _animList        = [_captive, _captor, _forceExecution] call SFSM_fnc_captorAbuseAnimList;
private _wait            = true;
private _condition       = { _this call SFSM_fnc_captorAbuseCondition;};
private _midFnc          = { _this call SFSM_fnc_captorAbuseOnAnimChange;};
private _postFnc         = {};
private _timeLimit       = (count _animList)*10;
private _ignoreWrongAnim = true;

private _params = [
    _captor, 
    _animList,
    _wait,
    _condition,
    _midFnc,
    _postFnc,
    _timeLimit,
    _ignoreWrongAnim
];

_params;