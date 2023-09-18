params["_event"];
if(!is3DEN)    exitWith{};
if(canSuspend) then{sleep 0.15;};

private _all = (all3DENEntities#3);
private _fipos = _all select {typeOf _x isEqualTo "SFSM_FIPO"};
private _indicators = [];
{_indicators append (_x getVariable ["indicators", []]);} forEach _fipos;

    private _toDelete = (all3DENEntities#0) select {
        [_x, _indicators] call FIPO_fnc_isDeleteableIndicator;
};

private _count = count _toDelete;
if(_count > 0)then{
    private _msg = ["SFSM: Cleaned up ", _count, " old fipo-indicators."] joinString "";
    systemChat _msg;
    diag_log _msg;
    delete3DENEntities _toDelete;
};

private _groups = _indicators apply {group _x};
_indicators join (_groups#0);
add3DENConnection ["Group", _indicators, (_indicators#0)];
_groups = _groups select {count units _x < 1};
{deleteGroup _x;} forEach _groups;

true;