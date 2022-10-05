private _AGLPos = false;
params ["_unitArr", "_AGLPos"];
if(_unitArr isEqualTo [])exitWith{[]};
private _aimPositions = [];

{
  private _pos = aimPos _x;
  if(_AGLPos)then{_pos = ASLToAGL _pos};
  _aimPositions pushBack _pos;
  
} forEach _unitArr;
_aimPositions;