params["_man"];
private _moveRegistry = _man getVariable "SFSM_unitData"get"moveRegistry";
private _validMoves   = _moveRegistry select {
    private _distance = _man distance2D (_x#1);
    _distance > 5
};

if(_validMoves isEqualTo [])exitWith{time;};

private _latestMove = ([_validMoves, [], {_x#0}, "DESCEND"] call BIS_fnc_sortBy)#0;
private _timePassed = time - (_latestMove#0);

_timePassed;