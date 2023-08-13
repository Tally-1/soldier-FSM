params["_man", "_enemies", "_allies"];
private _enemyStrength = (count _enemies)/(count _allies);
private _canMove       = [_man, true, true, true] call SFSM_fnc_canRun;
private _injured       = [_man] call SFSM_fnc_manIsInjured;
private _noAmmo        = !([_man] call SFSM_fnc_hasAmmoForWeapon);
private _morale        = [_man, "morale"] call SFSM_fnc_unitData;

private _panic         = (_noAmmo  && {_canMove});
private _surrender     = (_noAmmo  && {_canMove && {_enemyStrength > 2 && {_injured}}});
private _flee          = (_canMove && {_enemyStrength > 1.5});

if(_morale > 1.3
&&{_canMove
&&{_noAmmo isEqualTo false}})
exitWith{"fight";};

if(_surrender) exitWith{"surrender";};
if(_panic)     exitWith{"panic";};
if(_flee)      exitWith{"flee"};


"fight";