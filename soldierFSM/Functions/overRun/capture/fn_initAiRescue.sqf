params["_man", "_victim"];
private _vicPos = getPosATLVisual _victim;
[
    _man,
    _vicPos,
    60,
    3,
    2,
    [[_man, _victim], false, SFSM_fnc_AiRescue]

] spawn SFSM_fnc_forceMove2;

[_man, "Rescuing friendly"] call SFSM_fnc_setAction;
[_victim, "Being rescued"] call SFSM_fnc_setAction;

true;