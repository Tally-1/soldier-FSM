//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params[
    '_man', 
    '_building', 
    '_dodge', 
    '_entrance', 
    '_positions',
    '_enemyVehicle'
    ];
private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")exitwith{true;};

private _WaitTimer = time + 20;
private _startTime = time;
private _hide = !isNil '_enemyVehicle';

if!(_action == 'none')
then{waitUntil{
        sleep 1; 
        ([_man, "action"] call SFSM_fnc_unitData == 'none' 
        || time > _WaitTimer)};
    };

_action = [_man, "action"] call SFSM_fnc_unitData;
if!(_action == 'none')exitWith{};

private _startSpeedMode = speedMode _man;
private _pos = _positions#((count _positions)-1);
private _completedIndoorPos = 0;
private _actionText = "dodging inside building";
private _hideInPlace = false;

if!(_dodge)
then{_actionText = "taking cover inside building"};

if(_hide)
then{
    _actionText = "hiding inside building";
    private _currentBuilding = [_man] call SFSM_fnc_currentBuilding;
    if(!isNil "_currentBuilding")then{_hideInPlace = true;};
};
// [(typeName _enemyVehicle), 2] call dbgmsg;
if(_hideInPlace)exitWith{[_man, _enemyVehicle, true] spawn SFSM_fnc_doHide;};

[_man, "action", _actionText] call SFSM_fnc_unitData;



_man setUnitPos "UP";
_man setAnimSpeedCoef SFSM_sprintSpeed;
_man setSpeedMode "FULL";


// private _script = 
[_man,(_entrance), 60, 5] call SFSM_fnc_forceMoveToPos2;
// waitUntil{sleep 1; scriptDone _script;};

private _j = 1;
{
    
    private _baseText = "CQB: taking cover pos: ";
    if(_dodge)then{_baseText = "CQB: dodging pos: ";};
    if(_hide)then{_baseText = "CQB: hiding pos: ";};

    private _progressText = [_baseText, _j]joinString "";
    [_man, "action", _progressText] call SFSM_fnc_unitData;
    // private _script = 
    [_man, _x, 4, 2] call SFSM_fnc_clearCQBPos;
    // waitUntil{sleep 1; scriptDone _script;};

    private _currentBuilding = [_man] call SFSM_fnc_currentBuilding;
    private _endLoop = false;
    
    if(_man distance _x <= 2
    &&{(!isNil '_currentBuilding')
    &&{_currentBuilding == _building}})
    then{
            _completedIndoorPos = _completedIndoorPos+1;
            if(_dodge)then{_endLoop = true;};
        };

    if(_completedIndoorPos >= 2)then{_endLoop = true;};
    if((_man distance2D _building) >= 100 
    && {time - _startTime > 30})then{_endLoop = true;};

    if(_endLoop)exitwith{};
    _j=_j+1;
} forEach _positions;

private _distance = _pos distance _man;
private _moveToFinalPos = _completedIndoorPos >= 2 && {_distance > 1 && {! _dodge}};

if(_moveToFinalPos)
then{
       private _baseText = "CQB: Moving to cover position";
       if(_hide)then{_baseText = "CQB: Moving to hiding position ";};

     [_man, "action", _baseText] call SFSM_fnc_unitData;
    //  private _script = 
     [_man, _pos, 30, 1.9] call SFSM_fnc_clearCQBPos;
    //  waitUntil{sleep 1; scriptDone _script;};
};

_man setUnitPos "AUTO";
_man setAnimSpeedCoef 1;
_man setSpeedMode _startSpeedMode;
[_man, "action", "Ending"] call SFSM_fnc_unitData;

if(_hide)exitWith{[_man, _dodge, _pos, _enemyVehicle] spawn SFSM_fnc_endMoveIntoHouse;};

[_man, _dodge, _pos] spawn SFSM_fnc_endMoveIntoHouse;

true;