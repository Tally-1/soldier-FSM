params["_man", "_enemies", "_allies"];
private _enemyStrength = (count _enemies)/(count _allies);
private _canMove       = [_man, true, true, true] call SFSM_fnc_canRun;
private _injuries      = damage _man;
private _legDamage     = getAllHitPointsDamage _man#2#10;
private _injured       = (selectMax [_injuries, _legDamage])>0.25;
private _noAmmo        = !([_man] call SFSM_fnc_hasAmmoForWeapon);
private _panic         = (_noAmmo  && {_canMove});
private _surrender     = (_noAmmo  && {_canMove && {_enemyStrength > 2 && {_injured}}});
private _flee          = (_canMove &&{_enemyStrength > 1.5});


if(_surrender) exitWith{"surrender";};
if(_panic)     exitWith{"panic";};
if(_flee)      exitWith{"flee"};


"fight";