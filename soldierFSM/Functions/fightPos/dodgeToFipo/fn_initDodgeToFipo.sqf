params ["_man", "_enemy"];

private _canMove = [_man] call SFSM_fnc_availableAiSoldier;
if(_canMove isEqualTo false) exitWith{false;};

private _fipos = SFSM_fipositions select {[_man, _x] call SFSM_fnc_isDodgeFipo;};
if(_fipos isEqualTo [])      exitWith{false;};

private _alreadyDodging = _man getVariable ["fipoDodgeOn", false];
if(_alreadyDodging)          exitWith{false;};



[_man, _fipos, _enemy] spawn SFSM_fnc_dodgeToFipo;


true;