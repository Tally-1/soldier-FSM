params["_man", "_targets"];

if(_targets isEqualTo [])exitWith{[]};

private _tList = [];

{
    private _target      = _x;
    private _shoulderPos = [(aimPos _man), 0.2] call Tcore_fnc_AddZ;
    private _knowledge   = _man knowsAbout _target;    
    private _visibility  = [_man, "VIEW", _target] checkVisibility [_shoulderPos, (eyePos _target)];
    private _distance    = _man distance _target;

    if(_knowledge > 0)then{_knowledge = _knowledge/4};

    if(_knowledge > 0
    &&{_visibility > 0
    &&{[_x] call SFSM_fnc_canRun
    &&{[_man, _target] call SFSM_fnc_hostile}}})then{
        _tList pushBack [_target, _knowledge, _visibility, _distance];
    };

    
} forEach _targets;

if(_tList isEqualTo [])exitWith{[]};

//this algo should be updated with some params to make the function more dynamic.
private _sortAlgo = { 
    private _target     = _x#0;
    private _knowledge  = _x#1;
    private _visibility = _x#2;
    private _distance   = _x#3;
    (_distance / _visibility);
};

_tList = ([_tList, [], _sortAlgo, "DESCEND"] call BIS_fnc_sortBy);

_tList;