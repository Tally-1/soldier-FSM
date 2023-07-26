//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


params["_unitA", "_unitB"];
if!([_unitA] call SFSM_fnc_isRealMan)exitWith{[("logic detected" call dbgmsg), ""]};
if!([_unitB] call SFSM_fnc_isRealMan)exitWith{[("logic detected" call dbgmsg), ""]};

private _posA          = (getPos _unitA);
private _posB          = (getPos _unitB);
private _midPos        = [_posA, _posB] call Tcore_fnc_getMidpoint;
private _nearestBattle = [_midPos] call SFSM_fnc_nearestBattle;

if!(typeName _nearestBattle == "HASHMAP")
exitWith{["start", ""]};

private _battlePos    = _nearestBattle     get "center";
private _battleKey    = str(_nearestBattle get "center");
private _battleRadius = _nearestBattle     get "radius";
private _distanceA    = _posA distance2D _battlePos;
private _distanceB    = _posB distance2D _battlePos;
private _distToBattle = _midPos distance2D _battlePos;


private _insideBattle = ((_distanceA < _battleRadius
                      &&{_distanceB < _battleRadius})
                      || _distToBattle < _battleRadius);

if(_insideBattle)exitWith{["join", _battleKey]};


private _AtoB            = (_posA distance2D _posB);
private _thisRadius      = (_AtoB / 2);
private _combinedRadius  = _battleRadius + _thisRadius;

private _maxDistance     = round(selectMax[_distToBattle, _distanceA, _distanceB]);
private _expand          = (_combinedRadius > _distToBattle);

private _addedRadius     = (_maxDistance - _battleRadius);

if(_expand)exitWith{["expand", _battleKey, _addedRadius]};

["start", ""];