params[
   ["_building", nil, [objNull]],
   ["_posOnly",   false, [false]]
];
private _positionsAndName = [_building, false, false,"Memory"] call SFSM_fnc_selectionMap;
private _isDoor    = { "door" in _this && {"trigger" in _this}};
private _isWindow  = { "glass" in _this && {"effects" in _this}};
private _positions = [];

{
   _x params[
      ["_pos", nil,  [[]]],
      ["_name", nil, [""]]
   ];
   private _valid = _name call _isDoor or {_name call _isWindow};
   if(_valid) then{
      if(_posOnly)
      then{_positions pushBackUnique _pos;}
      else{_positions pushBackUnique [_pos, _name];};
   };
   
} forEach _positionsAndName;

_positions;