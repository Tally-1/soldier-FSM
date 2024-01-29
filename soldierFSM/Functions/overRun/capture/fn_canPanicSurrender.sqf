params[
	["_man", nil, [objNull]]
];

private _surrendered = _man getVariable ["SFSM_surrendered", false];
if(_surrendered isEqualTo true)exitWith{false;};

private _inPanic = _man getVariable ["SFSM_panic", false];
if(_inPanic isEqualTo false)exitWith{false;};

private _surrounded = [_man] call SFSM_fnc_isSurrounded;
if(_surrounded isEqualTo false)exitWith{false;};

private _unconscious = [_man] call SFSM_fnc_isUncon;
if(_unconscious isEqualTo true)exitWith{false;};

true;