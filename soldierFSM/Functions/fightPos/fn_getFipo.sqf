params["_man"];
private _fiPositions = synchronizedObjects _man select {typeOf _x isEqualTo "SFSM_FIPO"};
if(_fiPositions isEqualTo [])exitWith{};

private _fightingPos = _fiPositions#0;

_fightingPos;