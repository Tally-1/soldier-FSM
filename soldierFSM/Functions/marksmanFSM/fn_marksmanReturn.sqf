params["_marksman", "_battleKey", "_startPos"];
private _regroup = [_marksman] call SFSM_fnc_forcedRegroup;
if(_regroup)exitWith{true;};

private _battle = SFSM_battles get _battleKey;
if(isNil "_battle")exitWith{false;};

private _battleCenter = _battle get "center";
private _battleRadius = _battle get "radius";
private _leftBattle   = _marksman distance2D _battleCenter > _battleRadius;

private _returnToStart = _startPos distance _marksman > 300 || _leftBattle;
if(_returnToStart)exitWith{
    [_marksman, _startPos] spawn SFSM_fnc_marksmanReturnMove;
    true;
};

false;