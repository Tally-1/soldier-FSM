//Description: Returns the average relative direction to a position from an array of positions.
//Does accept objects as well as positions.
//For a maxdir and minDir return then set 3rd param as true (default is false)
private _maxMin = false;
params["_posArr", "_relPos", "_maxMin"];
private _relDirs   = [];

{
	
			_relDirs pushBackUnique (_x getDir _relPos) call Tcore_fnc_formatDir;
	
} forEach _posArr;

private _avgDir = ([_relDirs] call Tcore_fnc_average);//[([_relDirs] call Tcore_fnc_average)] call Tcore_fnc_formatDir;

// diag_log [_relDirs, "---> avg: ", _avgDir] joinString "";

if!(_maxMin)exitWith{_avgDir};


[(selectMax _relDirs), (selectMin _relDirs)];