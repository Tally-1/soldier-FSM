params["_man"];
private _fipo = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")exitWith{};

private _animation = toLowerANSI (_man getVariable "SFSM_wantedAnim");
private _lRight    = ("right" in _animation);
private _lLeft     = ("left" in _animation);
private _leaning   = (_lRight || _lLeft);
if!(_leaning)exitWith{};

private _data = _man getVariable "SFSM_animData";
if(isNil "_data")exitWith{};

private _displacement = _data#4;
private _offSet = [_displacement, 0,0];
if(_lLeft)then{_offSet = [0 -_displacement, 0,0];};

[_man, 0.02, _offSet] spawn SFSM_fnc_tempPegToFipo;

true;