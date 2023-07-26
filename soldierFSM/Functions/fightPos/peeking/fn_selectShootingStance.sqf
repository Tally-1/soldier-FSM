params["_stances"];
_stances = _stances select {_x#0 > -1};
if(_stances isEqualTo [])exitWith{};

private _shootingStance = selectRandom _stances;

_shootingStance;