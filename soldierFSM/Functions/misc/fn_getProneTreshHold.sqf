params["_man"];
private _treshHold = 0.9;
private _morale = [_man, "morale"] call SFSM_fnc_unitData;
if(isNil "_morale") exitWith{_treshHold;};
if(_morale > 1)     exitWith{_treshHold;};

_treshHold = _treshHold*_morale;

if(_treshHold < 0.1)then{_treshHold = 0.1;};

_treshHold;