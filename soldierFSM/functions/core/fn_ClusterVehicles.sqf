params["_clustersDataArr"];
private _vehicles   = [];

{
    private _objects    = _x#1;
    private _iterations = (count _objects)-1;

    for "_i" from 0 to _iterations
    do{
        private _object = _objects#_I;

        if!(_object isKindOf "man")
        then{_vehicles pushBackUnique _object};
    };

} forEach _clustersDataArr;

_vehicles