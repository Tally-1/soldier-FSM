params[
    ["_man", nil, [objNull]]
];
private _moveRegistry = _man getVariable "SFSM_unitData" get "moveRegistry";
private _count        = count _moveRegistry;
private _group        = group _man;
private _moveData = [
    round time,
    ([getPosATLVisual _man] call Tcore_fnc_roundPos),
	(leader _group isEqualTo _man),
	([_group] call SFSM_fnc_hasActiveWp)
];

_moveRegistry pushBack _moveData;

if(_count > 30)then{_moveRegistry deleteAt 0;};

_man getVariable "SFSM_unitData" set ["moveRegistry", _moveRegistry];