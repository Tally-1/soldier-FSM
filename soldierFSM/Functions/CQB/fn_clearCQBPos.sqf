//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _maxTime = 10;
private _maxDistance = 1.1;
params ["_man", "_pos", "_maxTime", "_maxDistance"];
private _timer = time + _maxTime;
private _distance = round(_man distance _pos);

//disable ai functions that disturbs movement
[_man, false] call Tcore_fnc_toggleAiMoveInhibitors;

//disable disturbing behaviour
_man setBehaviour "AWARE";
_man setCombatBehaviour "AWARE";
_man setUnitPos "UP";

//move to position, stop targeting
_man doMove _pos;
_man doTarget objNull;

while {sleep 1; _distance > _maxDistance} do {

//look for and engage close enemies.
// private _killEnemies = 
[_man, _maxTime] call SFSM_fnc_CQBTargetEnemies;
// waitUntil{scriptDone _killEnemies};


//   private _currentDistance = ((eyePos _man) distance2d _pos);
    private _currentDistance = ((getPos _man) distance _pos);
    private _hasMovedCloser = _distance > _currentDistance;
    if(! _hasMovedCloser)
    then{
            _man doMove _pos;
            _man doTarget objNull;
        };
  
    _distance = _currentDistance;
    if(_distance < _maxDistance)                     exitWith{false};
    if(time > _Timer)                                 exitWith{false};
    if(!alive _man)                                     exitWith{false};
    if!([_man, true] call SFSM_fnc_canRun)           exitWith{false};

};

//enable Standard AI
[_man, true] call Tcore_fnc_toggleAiMoveInhibitors;

true;