params["_battleField"];

private _continue = (!isNil "_battleField");

while {_continue} do {
    sleep 10;
    if(isNil "_battleField")exitWith{_continue = false;};
    private _continue = [_battlefield] call SFSM_fnc_battleOverRun;
};

true;