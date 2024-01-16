params["_man"];
private _stance    = stance _man;
private _newStance = (SFSM_unitStances select {_x isNotEqualTo _stance})#0;
private _newPos    = SFSM_stanceToPosMap get _newStance;
private _canChange = [_man, _newPos, true, true] call SFSM_fnc_forcedUnitPosNoAnim;

if!(_canChange)then{
    [_man] call SFSM_fnc_resetBrain;
    _canChange = [_man, _newPos, true, true] call SFSM_fnc_forcedUnitPosNoAnim;
};

if!(_canChange)then{
    _canChange = [_man, _newPos, true, true] call SFSM_fnc_forcedUnitPosNoAnim;
};

_canChange;