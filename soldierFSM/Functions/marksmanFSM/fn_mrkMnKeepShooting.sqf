params ["_marksman", "_target", "_timer"];

if!([_marksman, _target] call SFSM_fnc_viableTarget)exitWith{
    "target not viable" call dbgmsg;
};

if(time > _timer)exitWith{
    "timer expired" call dbgmsg;
};

private _visibility = [_marksman, "VIEW", _target] checkVisibility [(eyepos _marksman), (aimPos _target)];
if(_visibility < 0.1)exitWith{
    "visibility too low" call dbgmsg;
};


"true";