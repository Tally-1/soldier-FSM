params[
    ["_healer",      nil, [objNull]], 
    ["_unconscious", nil, [objNull]]
];

if(!alive _healer)      exitWith{false};
if(!alive _unconscious) exitWith{false};

private _isUncon = [_healer] call SFSM_fnc_isUncon;
if(_isUncon)exitWith{false};

private _notUncon = !([_unconscious] call SFSM_fnc_isUncon);
if(_notUncon)exitWith{false};

private _prevHealerDeath      = [_unconscious, "healerDeathTime"] call SFSM_fnc_unitData;
if(isNil "_prevHealerDeath")exitWith{false};

private _timeSinceHealerDeath = time - _prevHealerDeath;
if (_timeSinceHealerDeath < 60)exitWith{false};

private _player = [_healer] call SFSM_fnc_isPlayer;
if(_player)exitWith{false};

private _hostile = [_healer, _unconscious] call SFSM_fnc_hostile;
if(_hostile)exitWith{false};

private _attached = attachedObjects _unconscious select {_x isKindOf "caManBase" &&{_x != _healer}};
if(_attached isNotEqualTo [])exitWith{false};

private _distance = _healer distance2D _unconscious;
if(_distance > 7)exitWith{false};

true;