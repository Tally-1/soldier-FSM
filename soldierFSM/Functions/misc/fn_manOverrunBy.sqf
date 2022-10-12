params['_man'];
private _nearEnemies = [_man, SFSM_overrunDistance, 'enemies'] call Tcore_fnc_nearKnownEnemies;
private _overRun = count _nearEnemies > 0;

if(_overRun)exitwith{(_nearEnemies#0)};

objNull;