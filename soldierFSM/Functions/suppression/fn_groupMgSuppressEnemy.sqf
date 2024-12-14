params [
    ['_group',     nil,                [grpNull]],
    ['_targetMap', createHashmap,[createHashmap]]
];
private _excluded = _targetMap getOrDefault ["targets",[]];
private _man      = [_group] call SFSM_fnc_firstValidManInGroup;
if(isNil "_man")exitWith{};

private _gunners  = units _group select {[_x]call SFSM_fnc_isAvailMgMan};
if(_gunners isEqualTo [])exitWith{};

private _targets  = [_man, 300] call SFSM_fnc_nearKnownEnemyInf;
if(_targets isEqualTo [])exitWith{};

private _list   = [_gunners, _targets] call SFSM_fnc_sortShooterTargetList;
private _action = "Battlefield Suppression";
{
    private _shooter = _x#0;
    private _target  = _x#1;
    
    [_shooter, _target, _action] spawn SFSM_fnc_engageAndSuppress;
    _excluded pushBackUnique _target;

    
} forEach _list;

true;