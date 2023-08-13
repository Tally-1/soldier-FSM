params["_man"];

private _maxAddedCoef = 0.5;
private _enemyCount    = count ([_man] call SFSM_fnc_nearEnemies);

if (_enemyCount isEqualTo 0)exitWith{0;};

private _enemyFactor = _enemyCount/10;

if(_enemyFactor > _maxAddedCoef)then{_enemyFactor = _maxAddedCoef};

if(_enemyFactor > 0)then{
    _enemyFactor = _enemyFactor -(_enemyFactor*2);
};

_enemyFactor;