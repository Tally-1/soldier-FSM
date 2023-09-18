/*
I apologize to anyone having to read this spaghettin nightmare.
The main reason for the repetitive code is that the variable containing the vr-mans group
seems to not be stored when called in an external file.
hence no refactoring is possible.
-Tally.
*/
params["_fipo"];

private _all = (all3DENEntities#3);
private _fipos = _all select {typeOf _x isEqualTo "SFSM_FIPO"};
private _indios = [];
{_indios append (_x getVariable ["indicators", []]);} forEach _fipos;
if(count _indios > 0)then{
    FIPO_indicatorGroup = group (_indios#0);
};

private _fipoStances = 
    [
        "coverstance",
        "shootingstance",
        "shootingstanceright",
        "shootingstanceleft"
    ];
private _indicators  = (_fipo getVariable ["indicators", []]) select {!isNull _x};
private _count       = count _indicators;
private _countNeeded = count (_fipoStances select {_fipo getVariable _x > -1});

if(_count isEqualTo _countNeeded) exitWith{false;};

if(_count > 0)          then{[_fipo] call FIPO_fnc_deleteIndicators; _indicators = [];};
if(isNil "fipo_indIds") then{fipo_indIds = [];};

private _type        = [_fipo] call FIPO_fnc_indicatorType;
private _groupNeeded = isNil "_group";

if(isNil "FIPO_vrMan"
||{isNull FIPO_vrMan})then{
    FIPO_vrMan  = create3DENEntity ["Object", _type, [0,0,0], true];
    [FIPO_vrMan, _fipo] call FIPO_fnc_initVrMan;
    _indicators pushBack FIPO_vrMan;
    FIPO_indicatorGroup = (group FIPO_vrMan);
}else{
    private _vrMan = FIPO_indicatorGroup create3DENEntity ["Object", _type, [0,0,0]];
    [_vrMan, _fipo] call FIPO_fnc_initVrMan;
    _indicators pushBack _vrMan;
};
if(_countNeeded -(count _indicators) isEqualTo 0)exitwith{_fipo setVariable ["indicators", _indicators];};


private _vrMan = FIPO_indicatorGroup create3DENEntity ["Object", _type, [0,0,0]];
[_vrMan, _fipo] call FIPO_fnc_initVrMan;
_indicators pushBack _vrMan;
if(_countNeeded -(count _indicators) isEqualTo 0)exitwith{_fipo setVariable ["indicators", _indicators];};


_vrMan = FIPO_indicatorGroup create3DENEntity ["Object", _type, [0,0,0]];
[_vrMan, _fipo] call FIPO_fnc_initVrMan;
_indicators pushBack _vrMan;
if(_countNeeded -(count _indicators) isEqualTo 0)exitwith{_fipo setVariable ["indicators", _indicators];};


_vrMan = FIPO_indicatorGroup create3DENEntity ["Object", _type, [0,0,0]];
[_vrMan, _fipo] call FIPO_fnc_initVrMan;
_indicators pushBack _vrMan;
if(_countNeeded -(count _indicators) isEqualTo 0)exitwith{_fipo setVariable ["indicators", _indicators];};

_indicators;
