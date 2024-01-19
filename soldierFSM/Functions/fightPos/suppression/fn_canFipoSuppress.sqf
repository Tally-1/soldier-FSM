params["_man"];
private _fipo = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")exitWith{false;};

private _isMarksman = [_man] call SFSM_fnc_isMarksman;
if(_isMarksman)exitWith{false;};

private _allowed = _fipo getVariable "allowsuppression";
if(_allowed isEqualTo false)exitWith{false;};

private _timeSincePrevious = time - ([_man, "lastFipoSuppression"] call SFSM_fnc_unitData);
if(_timeSincePrevious < 30)exitWith{false;};

true;