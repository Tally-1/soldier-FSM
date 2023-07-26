//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Determines the size of a battlefield uses a center position and a minimum radius

// Params: [_pos, _baseRadius] - _pos([number, number, number]), _baseRadius(number)

// Return value: _returnRadius(number)

// Example: [(getPos _unitA), 300] call Tcore_fnc_battlefieldRadius

params["_pos", '_baseRadius'];

private _returnRadius = _baseRadius;
private _checkRadius  = _baseRadius*2;

if(_checkRadius < 300)then{_checkRadius = 300};
private _units        = _pos nearEntities ['CAManBase', _checkRadius];

private _filter = {
    ([_x] call SFSM_fnc_isRealMan
    &&{(side _x) in [east,west,independent]
    &&{([_x, "currentBattle"] call SFSM_fnc_unitData) == "none"}})
};

_units = _units select _filter;
private _maxRadius    = [_pos, _units] call Tcore_fnc_clusterSize;

if(_maxRadius > _baseRadius)then{_returnRadius = _maxRadius};

_returnRadius = _returnRadius*1.33;

_returnRadius;