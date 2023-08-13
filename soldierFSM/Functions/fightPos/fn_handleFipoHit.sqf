params["_man", "_fipo"];
if((alive _man isEqualTo false)
|| {[_man] call SFSM_fnc_isUncon isEqualTo true})
then{
    [_man] call SFSM_fnc_getOutFipo;
};