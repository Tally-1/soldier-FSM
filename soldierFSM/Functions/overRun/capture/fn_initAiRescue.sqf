params["_man", "_victim"];
private _vicPos = getPosATLVisual _victim;
[
    _man,
    _vicPos,
    60,
    3,
    nil,
    [[_man, _victim], true, SFSM_fnc_AiRescue]

] spawn SFSM_fnc_forcedMove;

[_man, "Rescuing friendly"] call SFSM_fnc_setAction;
[_victim, "Being rescued", 10] spawn SFSM_fnc_flashAction;

true;