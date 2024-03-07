params["_man"];
private _fipo      = [_man] call SFSM_fnc_getFipo;
private _distance  = _man distance _fipo;
private _destroyed = _fipo getVariable ["destroyed", false];
private _tooFar    = _distance > SFSM_FipoGetOutDistance;
private _getOut    = _destroyed || _tooFar;

if(isNil "_fipo")                                  exitWith{false;};
if(_distance < 1.1)                                exitWith{false;};
if([_man, "fipo-sidestep"] call SFSM_fnc_unitData) exitWith{false;};

if(_getOut)exitWith{
    [_man] call SFSM_fnc_getOutFipo; 
    false;
};

doStop _man;
_man doFollow _man;
_man setPosASL (getPosASL _fipo);
_man doMove    (getPosATL _fipo);
_man setDestination [(getPosATL _fipo), "DoNotPlan", false];
_man setDestination [(getPosATL _fipo), "LEADER DIRECT", false];
_man attachTo [_fipo, [0,0,0.5]];
_man disableAI "PATH";

[_man, "correcting fipo-pos", 0.8] spawn SFSM_fnc_flashAction;
["Fipo error, man outsided of assigned fipo",1] call dbgmsg;

[_man] spawn {
    params["_man"];
    sleep 0.5; 
    detach _man;
    // _man disableAI "PATH";
    _man setPosASL getPosASL ([_man] call SFSM_fnc_getFipo);
    [_man, true] call SFSM_fnc_resetBrain;
    sleep 0.3;
    _man setPosASL getPosASL ([_man] call SFSM_fnc_getFipo);
    [_man] spawn SFSM_fnc_tempPegToFipo;
};

true;