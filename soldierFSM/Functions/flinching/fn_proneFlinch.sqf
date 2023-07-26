params ["_man"];

private _proneDuck = "AadjPpneMstpSrasWrflDdown";
private _canRoll   = [_man] call SFSM_fnc_canRoll;

if(_canRoll
&&{random 1 < 0.7})exitWith{[_man] spawn SFSM_fnc_Roll;};

_man playMoveNow _proneDuck;

sleep 3;
[_man] call SFSM_fnc_normalizeStance;
