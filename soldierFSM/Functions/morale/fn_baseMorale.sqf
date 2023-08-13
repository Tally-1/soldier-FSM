params["_man", "_storeFactors"];
private _current     = [_man, "baseMorale"] call SFSM_fnc_unitData;
private _lastCheck   = [_man, "baseMoraleChecked"] call SFSM_fnc_unitData;

if(time - _lastCheck < 10)exitWith{_current};

private _base        = 1;
private _max         = 1.7;
private _min         = 0.3;
private _addedCoef   = ([_man, _storeFactors] call SFSM_fnc_moraleFactors)#0;
private _finalMorale = _base * (1+(_addedCoef));


if(_finalMorale > _max)then{_finalBase = _max;};
if(_finalMorale < _min)then{_finalBase = _min;};

[_man, "baseMoraleChecked", time] call SFSM_fnc_unitData;

_finalMorale;