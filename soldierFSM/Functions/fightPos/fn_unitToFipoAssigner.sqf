if(!isNil "SFSM_utfp")exitWith{};
SFSM_utfp = true;

private _fipos         = SFSM_allFipos select{[_x] call SFSM_fnc_fipoAvailable;};
private _menAndFipos   = (allUnits select {[_x] call SFSM_fnc_availableAiSoldier}) 
        apply {[_x, ([_x, _fipos] call SFSM_fnc_getNearest)]};

_menAndFipos = [_menAndFipos, [], {(_x#0) distance (_x#1)}, "ASCEND"] call BIS_fnc_sortBy;

_menAndFipos = _menAndFipos select {
	_x params ["_man", "_fipo"];
	(leader group _man) distance2D _fipo < SFSM_fipoGetInDistance;
};

private _inUse = [];
{
	private _man  = _x#0;
	private _fipo = _x#1;
	private _canMoveIn = ([_man, _fipo] call SFSM_fnc_canMoveInFipo && {!(_fipo in _inUse)});
	if(_canMoveIn)
	then{[_man, _fipo] spawn SFSM_fnc_MoveInFipo; _inUse pushBackUnique _fipo;};	
} forEach _menAndFipos;

_fipos = _fipos select {(!(_x in _inUse)) && {[_x] call SFSM_fnc_fipoAvailable}};

[_fipos, true] call SFSM_fnc_fipoAssigner;


SFSM_utfp = nil;

true;