params["_man", "_targetHouse"];
private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield = SFSM_Battles get _battleKey;
private _units = missionNamespace getVariable (_battleField get "units");
private _filter = { 
                    private _isClearing = false;
                    private _targetBuilding = [_x, "targetBuilding"] call SFSM_fnc_unitData;
                    _targetBuilding = missionNamespace getVariable _targetBuilding;
                    ((!isNil "_targetBuilding")
                    &&{_targetBuilding == _targetHouse
                    &&{(side _x)==(side _man)}})
                  };
_units = _units select _filter;
private _unitsClearing = count _units;


//return result.
(_unitsClearing >= SFSM_CQBunitCap)