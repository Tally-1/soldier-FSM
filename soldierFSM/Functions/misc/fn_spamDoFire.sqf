params["_man", "_timeLimit"];
private _target = getAttackTarget _man;
_man reveal   _target;
_man doTarget _target;
_man doFire   _target;

while{!([_man, _timeLimit] call SFSM_fnc_peekEnded)}do{
    private _timeSinceLastOut = time - ([_man, "last_bullet_fired"] call SFSM_fnc_unitData);
    _target = getAttackTarget _man;
    private _eyeDir = round getDir _man;//eyeDirection _man;
    private _targetDir = round (_man getDir _target);

    if(_eyeDir isEqualTo _targetDir)then{
        private _weaponMode = currentWeaponMode _man;
        _man forceWeaponFire [(currentWeapon _man), _weaponMode];
    };
    
    if(alive _target
    &&{_timeSinceLastOut > 1})then{
        _man doFire _target;
    };

    sleep 1;

    if([_man, _timeLimit] call SFSM_fnc_peekEnded)exitWith{};
};

_man doTarget objNull;
true;