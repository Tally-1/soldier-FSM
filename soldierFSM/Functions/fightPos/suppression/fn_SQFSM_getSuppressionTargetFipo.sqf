params[
    ["_man",  nil, [objNull]],
    ["_fipo", nil, [objNull]]
];
private _pos     = getPosATLVisual _fipo;
private _dir     = getDirVisual _fipo;
private _rad     = 150;
private _center  = [_pos, _dir, _rad] call SFSM_fnc_sinCosPos2;
private _enemies = _center nearEntities ["caManBase", _rad] select {[_man, _x]call SFSM_fnc_validEnemy};
if(_enemies isEqualTo [])exitWith{};
private _target          = objNull;
private _knowledgeNeeded = (_fipo getVariable "minSupKnow") > 2;

{
    private _posOrObj = [_man, _x, _knowledgeNeeded, _fipo] call SQFM_fnc_getSuppressionTarget;
    if(!isNil "_posOrObj")
    exitWith{_target = _posOrObj};
    
} forEach _enemies;

if(typeName _target isEqualTo "ARRAY") exitWith{_target};
if(!isNull _target)                    exitWith{_target};

nil;