params[
    ["_path",nil,[[]]]
];
private _distances     = [];
private _totalDistance = 0;
for "_i" from 0 to (count _path -2)do{
    private _dist = (_path#_i)distance(_path#(_i+1));
    _distances pushBack _dist;
};

{
    _totalDistance=_totalDistance+_x;
    
} forEach _distances;

_totalDistance;