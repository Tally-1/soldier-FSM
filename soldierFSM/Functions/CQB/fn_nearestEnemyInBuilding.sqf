params[
   ["_man",      nil, [objNull]],
   ["_building", nil, [objNull]]
];
private _mySide    = side _man;
private _menInside = [_building, _mySide] call SFSM_fnc_unitsInBuilding;
if(_menInside isEqualTo [])exitWith{objNull;};

private _enemies = 
_menInside select {
   private _targetBuilding = [_x] call SFSM_fnc_currentBuilding;
   private _isHostile      = [_man, _x] call SFSM_fnc_hostile;
   _targetBuilding isEqualTo _building
   &&{_isHostile   isEqualTo true;};
};

if(_enemies isEqualTo [])exitWith{objNull;};

private _nearest = [_man, _enemies] call SFSM_fnc_getNearest;

_nearest;