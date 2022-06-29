params ['_battleField'];
private _timePassed = time - (_battlefield get "Started");

if(_timePassed < 30)exitwith{false};

private _sides = (_battlefield get "sides") call SFSM_fnc_sidesFromString;
if(count _sides < 2)exitWith{true};

private _unitsFighting = [_battleField] call SFSM_fnc_battlingUnits;

if(count _unitsFighting < 2)exitWith{true};

false;