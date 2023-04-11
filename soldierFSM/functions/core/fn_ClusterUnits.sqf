params["_clustersDataArr"];
private _units   = [];

{
	private _objects    = _x#1;
	private _iterations = (count _objects)-1;

	for "_i" from 0 to _iterations
	do{
		private _object = _objects#_I;

		if(_object isKindOf "CAManBase")
		then{_units pushBackUnique _object};
	};

} forEach _clustersDataArr;

_units