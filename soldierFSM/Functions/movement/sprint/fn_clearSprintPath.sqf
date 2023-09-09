params ["_man", "_pos"];

//To avoid spamming the LOS check, it is only run once pr 2 seconds pr man.
private _lastLosCheck = [_man, "lastSprintCheck"] call SFSM_fnc_unitData;
if(time - _lastLosCheck < 2)exitWith{false;};

// To avoid spamming the LOS check there is a global cap at 0.1 seconds.
if(time - SFSM_lastSprintLosCheck < 0.1)exitWith{false;};
SFSM_lastSprintLosCheck = time;

private _manPos = getPos _man;
private _aimPos = AGLToASL [_manPos#0, _manPos#1, 0.7];
private _ASLPos = ATLToASL [_pos#0, _pos#1, 0.7];

[_man, "lastSprintCheck", time] call SFSM_fnc_unitData;
private _objsInPath = lineIntersectsObjs [_aimPos, _ASLPos, _man, objNull, true, 5];
private _blockers   = [_objsInPath] call SFSM_fnc_noBushNoMan;
if(count _blockers > 0)exitWith{false;};

/*
This turned out to be too strict, if building clipping keeps being an issue I'll reactivate it. 
*/
private _nearest = objNull;
private _men = _objsInPath select {_x isKindOf "CaManBase" && {_x isNotEqualTo _man}};

if(count _men > 0)then{
    _nearest = [_man, _men] call SFSM_fnc_getNearest;
};

private _visibility = [_man, "VIEW", _nearest] checkVisibility [_aimPos, _ASLPos];
if(_visibility isEqualTo 0)exitWith{false;};

true;