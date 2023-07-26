params["_group"];
"Group is fleeing" call dbgmsg;
private _units   = units _group select {[_x, true, true, true] call SFSM_fnc_canRun};
if(count _units isEqualTo 0)exitWith{
    "No members left in squad, cannot flee." call dbgmsg;
    false;
};

private _enemies = [];

{
    _enemies append ([_x, 500] call SFSM_fnc_nearEnemies);
    // if(count _enemies > 0)exitWith{};

} forEach _units;

if(count _enemies isEqualTo 0)exitWith{
    "cannot flee, no enemies" call dbgmsg;
    false;
};

private _lost = [_group] call SFSM_fnc_battleLost;
_group setVariable ["SFSM_fled", true];

{
    [_x, "Group flee"] spawn SFSM_fnc_flashAction;

    // private _enemyStrength = (count _enemies)/(count _units);
    // private _overPowered   = _enemyStrength > 4;
    private _injuries      = damage _x;
    private _legDamage     = getAllHitPointsDamage _x#2#10;
    private _injured       = (selectMax [_injuries, _legDamage])>0.6;
    private _noAmmo        = !([_x] call SFSM_fnc_hasAmmoForWeapon);
    private _surrender     = (_noAmmo || _injured || _lost/*|| _overPowered*/);
    private _enemiesClose  = [_x] call SFSM_fnc_nearEnemies isNotEqualTo [];

    if(_surrender)
    then{
    if(_enemiesClose)then{
        [_x] spawn SFSM_fnc_surrender;
    }else{[_x] spawn SFSM_fnc_panic};
    }else{[_x, _enemies] spawn SFSM_fnc_flee;};
    
} forEach _units;

true;