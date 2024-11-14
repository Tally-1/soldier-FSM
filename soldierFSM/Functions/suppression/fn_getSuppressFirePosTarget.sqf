params[
    ["_shooter", nil,    [objNull]], 
    ["_target",  nil,    [objNull]]
];
private ["_suppressPos", "_suppressTarget"];
private _pos         = getPosATLVisual _shooter;
private _positions   = [_shooter, _target, 180, 400, 10,100] call SFSM_fnc_targetZoneCone;
private _bldPosArr   = [_pos, 100, true] call SFSM_fnc_nearBuildingPositions select {[_x, _target] call SFSM_fnc_validBuildingFirePos};

// Sort positions, but use buildingPositions first for more "coolness"
_positions = [_positions, [], {_pos distance2D _x}, "ASCEND"] call BIS_fnc_sortBy;
_positions insert [0,_bldPosArr];

{
    // Exit if a position has already been found.
    if(!isNil "_suppressPos")exitWith{};

    // Set pos altitude to chest height and transform to ASL format for linecheck.
    private _shootingPos = ATLToASL (_x vectorAdd [0,0,1.1]);
    private _newTarget   = [_shooter, _target, [], _shootingPos] call SFSM_fnc_getSuppressionTargetPosition;
    if(!isNil "_newTarget")exitWith{
        _suppressPos    = _x;
        _suppressTarget = _newTarget;
    };
} forEach _positions;

if(isNil "_suppressPos")exitWith{[]};


[_suppressPos, _suppressTarget];