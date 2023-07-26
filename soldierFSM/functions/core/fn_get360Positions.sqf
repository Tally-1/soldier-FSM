private _posCount = 32;
params ["_pos", "_radius", "_posCount"];
private _positions = [];
private _dir = 0;
private _dirIncrement = (360 / _posCount);

for "_i" from 0 to (_posCount -1)
do {
        private _newPos = [_pos#0, _pos#1, _dir, _radius] call Tcore_fnc_sinCosPos;
        _positions pushBack _newPos;
        _dir = _dir + _dirIncrement;
   };
_positions;