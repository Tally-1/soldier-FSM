private _unique = true; 
params["_source", "_target", "_unique"];
private _newArr = _target;

{
	if(_unique)	then{_newArr pushBackUnique _x}
				else{_newArr pushBack       _x};
} forEach _source;

_newArr