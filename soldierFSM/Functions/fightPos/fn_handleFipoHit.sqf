params["_man", "_fipo"];
if((!alive _man)
||{[_man] call SFSM_fnc_isUncon})
then{
    [_man] call SFSM_fnc_getOutFipo;
};