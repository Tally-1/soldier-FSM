params["_man"];

if(_man getVariable ["SFSM_stopCapBomb", false])
exitWith{
    _man setVariable ["SFSM_stopCapBomb", nil];
    false;
};

if(_man getVariable ["SFSM_stopCapBombAlways", false])
exitWith{false;};

true;