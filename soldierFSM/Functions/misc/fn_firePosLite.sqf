// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_target"];

private _targetPos = AGLToASL ([(getPos _target)#0, (getPos _target)#1, 1.6]);
private _hasLOS = ([_man, "VIEW", _target] checkVisibility [(aimPos _man), _targetPos]) > 0.8;

private _distance = (_man distance2D _target);
private _minDistance = 40;

private _formatNumber = { params["_number"];
if(_number < 0)then{_number = (_number - (_number*2));};
_number
};

//this will wheigh the height difference more when sorting.
private _sortingAlgo = {
    private _distance = _man distance _x;
    private _zDiff = ((AGLToASL _x)#2)- ((getPosASLVisual _target)#2);
    _zDiff = [_zDiff] call _formatNumber;

    (_distance + _zDiff)
    };
private _getAltitudeDiff = 
{
    params["_pos1", "_pos2"];
    private _z1 = (AGLToASL _pos1)#2;
    private _z2 = (AGLToASL _pos2)#2;
    private _diff = [(_z1 - _z2)] call _formatNumber;
    _diff;
};


private _altitudeDiff = [(getPos _man), (getPos _target)] call _getAltitudeDiff;
if(_hasLOS
&&{_distance > _minDistance
&&{_altitudeDiff < 2}})exitWith{(getPos _man)};


private _maxDistance = 150;
if(_distance > _maxDistance)then{_distance = _maxDistance;};
if(_distance < _minDistance)then{_distance = _minDistance;};

private _firePos = nil;
private _targetZ = _targetPos#2;
private _posArr = [_targetPos, _distance, 36] call Tcore_fnc_get360Positions;
_posArr = _posArr select {([_x, (getPos _target)] call _getAltitudeDiff) < 3};

if(count _posArr == 0)exitWith{"no positions left for lnchrman"call dbgmsg;nil;};

_posArr = ([_posArr, [], _sortingAlgo, "ASCEND"] call BIS_fnc_sortBy);


{
    private _pos = AGLToASL [_x#0,_x#1,1.5];
    private _hasLOS = ([_man, "VIEW", _target] checkVisibility [_pos, _targetPos]) > 0.8;
    if(_hasLOS)
    exitWith{
        _firePos = ASLToAGL _pos;
    };
    
} forEach _posArr;

if(isNil "_firePos")exitWith{};

_firePos;