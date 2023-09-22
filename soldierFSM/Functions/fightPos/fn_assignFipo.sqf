params["_fipo", "_squadLeaders", "_excludedMen"];
private _availableUnits = [];
private _fipoMan = objNull;

{
     if(_x distance2D _fipo < SFSM_fipoGetInDistance)
     then{_availableUnits append (units group _x)};

} forEach _squadLeaders;

if(_availableUnits isEqualTo [])exitwith{objNull};

private _ableUnits = _availableUnits select {
       (_x in _excludedMen) isEqualTo false   
    && {[_x, _fipo] call SFSM_fnc_canMoveInFipo
    }};

if(_ableUnits isEqualTo [])exitWith{objNull};

// Get nearest and move in.
private _fipoMan = [_fipo, _ableUnits] call SFSM_fnc_getNearest;
private _canMoveIn = [_fipoMan, _fipo] call SFSM_fnc_canMoveInFipo;
[_fipoMan, _fipo, _canMoveIn] spawn SFSM_fnc_moveInFipo;

if(_canMoveIn isEqualTo false)exitWith{objNull;};

//Show dynamic fipo while debugging.
if(SFSM_debugger
&&{_fipo getVariable "dynamicFipo"
&&{(isNil "_fipoMan") isEqualTo false 
}})then{
    [_fipo, false, true] call SFSM_fnc_showActiveFlanks;
};

_fipoMan;