//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_targetHouse"];
private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
if(isNil "_battleKey")exitwith{true;};
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