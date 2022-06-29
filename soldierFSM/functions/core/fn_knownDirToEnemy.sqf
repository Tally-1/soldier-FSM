private _distance = 500;
params['_man',"_distance"];
private _pos = getPos _man;
private _enemyPositions = [_man, _distance, 'positions'] call Tcore_fnc_nearKnownEnemies;

if(count _enemyPositions == 0)exitwith{};

private _dirToEnemies = [_enemyPositions, _pos] call Tcore_fnc_avgRelDir;

_dirToEnemies = [(_dirToEnemies - 180)] call Tcore_fnc_formatDir;

_dirToEnemies