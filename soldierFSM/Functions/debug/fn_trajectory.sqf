params["_posArr"];
private _trajectory = [];

for "_i" from 0 to (count _posArr -2) do{
    private _start = _posArr#_i;
    private _end   = _posArr#(_i + 1);
    
    _trajectory pushBack [_start, _end];
};

_trajectory;