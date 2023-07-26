params ["_man"];

private _playerUnits = [];
_playerUnits append allPlayers;
_playerUnits insert [0, playableUnits, true];
_playerUnits insert [0, switchableUnits, true];

if!(_man in _playerUnits)exitWith{false};

true;