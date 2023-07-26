params["_battleField"];
private _orMen = [];

private _men = missionNamespace getVariable (_battlefield get "units");
if(isNil "_men")exitWith{false;};

_men = _men select {([_x, true, true, true] call SFSM_fnc_canRun)};


{
    private _overRun = [_x] call SFSM_fnc_initOverRun;
    if(_overRun)then{_orMen pushBackUnique _x;};
    
} forEach _men;

private _count = count _orMen;

if(_count > 0)then{
    [[_count, " units was overRun"], 2] call dbgMsg;
    ["BFF_overRun", [_orMen]]    call CBA_fnc_localEvent;
};

true;