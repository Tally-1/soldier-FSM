params[
    ["_healer",  nil,[objNull]],
    ["_wounded", nil,[objNull]]
]; 
private _shooter    = _wounded getVariable "SFSM_prevShooter";
private _woundedPos = getPosATL _wounded;
private _shooterPos = getPosATL _shooter;
private _radius     = 100;
private _hostiles   = [_healer, _radius, _woundedPos] call SFSM_fnc_nearEnemies;
if(!isNull _shooter)then{
    private _hostilesSh = [_healer, _radius, _shooterPos] call SFSM_fnc_nearEnemies;
    _hostiles insert [0, _hostilesSh,true];
};

_hostiles = _hostiles select{_x isKindOf "caManBase"};
if(_hostiles isEqualTo [])exitWith{[[],[]]};

private _friendlies =  [_healer,  _radius] call SFSM_fnc_nearAvailFriendlyMen;
_friendlies insert [0, [_wounded, _radius] call SFSM_fnc_nearAvailFriendlyMen, true];

_friendlies deleteAt (_friendlies find _healer);

[_friendlies, _hostiles];