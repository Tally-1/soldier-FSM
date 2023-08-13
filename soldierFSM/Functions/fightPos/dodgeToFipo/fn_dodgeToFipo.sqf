params ["_man", "_fipos", "_enemy"];

if([_man] call SFSM_fnc_isUncon)exitWith{
	[_man, "none"] call SFSM_fnc_setAction;
};

_man setVariable ["fipoDodgeOn", true];

[_man, "Dodging to FIPO"] call SFSM_fnc_setAction;
private _target = [_man, _fipos] call SFSM_fnc_getNearest;
private _move   = [_man, (getPosATLVisual _target), SFSM_DodgeTimer, 10, 3] spawn SFSM_fnc_forceMove2;

waitUntil{sleep 0.1; scriptDone _move;};

private _validFipo = [_man, _target] call SFSM_fnc_isDodgeFipo;

if(_validFipo isEqualTo false)exitWith{
   [_man] call SFSM_fnc_failFipoMove;
   _man setVariable ["fipoDodgeOn", false];
   // [_man, "FIPO unavailable"] spawn SFSM_fnc_flashAction;
   // [_man, "none"] call SFSM_fnc_setAction;
};

private _canTeleport = [_man, _target] call SFSM_fnc_canTeleportFipo;

if(_canTeleport)exitWith{
	_man setVariable ["fipoDodgeOn", false];
    [_man, _target] call SFSM_fnc_getInFipo;
};

[_man, _target, true] spawn SFSM_fnc_moveInFipo;
_man setVariable ["fipoDodgeOn", false];


true;