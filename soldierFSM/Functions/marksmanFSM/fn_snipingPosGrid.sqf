params ["_marksman", "_target"];
private _targetPos     = getPosASL _target;
private _sniperPos     = getPosASL _marksman;
private _distance      = _target distance _marksman;
private _dir           = [_sniperPos getDir _targetPos] call Tcore_fnc_formatDir;


//in case the marksman is within 100m the position is skewed to allow for 
//marksmanship not CQB.
if(_distance < 100)then{ 
    private _dir2      = [_targetPos getDir _sniperPos] call Tcore_fnc_formatDir;
    private _newPos    = [_targetPos, _dir2, 125] call SFSM_fnc_sinCosPos2;
    private _available = [_newPos, 50, 25] call Tcore_fnc_availablePositions;
    if(_available isEqualTo [])exitWith{};

    _sniperPos = [_newPos, _available] call SFSM_fnc_getNearest;
    _distance  = _sniperPos distance _target;
    _dir       = [_sniperPos getDir _targetPos] call Tcore_fnc_formatDir;
};

private _center        = [_targetPos, _sniperPos, _distance*0.8] call Tcore_fnc_getMidPoint;

private _rightFlank    = [_center, (_dir+62.5), _distance] call SFSM_fnc_sinCosPos2;
private _leftFlank     = [_center, (_dir-62.5), _distance] call SFSM_fnc_sinCosPos2;

private _centerPositions = [_center,     _distance, 50] call Tcore_fnc_squareGrid;
private _rightPositions  = [_rightFlank, _distance, 50] call Tcore_fnc_squareGrid;
private _leftPositions   = [_leftFlank, _distance,  50] call Tcore_fnc_squareGrid;

private _positions = [];

_positions append _centerPositions;
_positions insert [0, _leftPositions,  true];
_positions insert [0, _rightPositions, true];

_positions;