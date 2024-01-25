params["_man"];
private _fipo      = [_man] call SFSM_fnc_getFipo;
private _destroyed = _fipo getVariable ["destroyed", false];

if(_destroyed)exitWith{ 
   [_man] call SFSM_fnc_getOutFipo;
   true;
};

false;