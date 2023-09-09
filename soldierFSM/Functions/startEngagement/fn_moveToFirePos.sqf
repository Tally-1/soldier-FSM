// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _nearEnemies = [];
params[
    "_man",        // the man who will shoot.
    "_movePos",   // where he will shoot from 
    "_targetPos" // the position he will shoot at.
    ];

_movePos = [_movePos#0,_movePos#1,0];
private _timer = time + SFSM_DodgeTimer;
private _distance = round(_man distance2d _movePos);


if(SFSM_forceDodge)
then{[_man, false] call Tcore_fnc_toggleAiMoveInhibitors};


_man setAnimSpeedCoef SFSM_sprintSpeed;

_man doMove (getPos _man);
_man doMove _movePos;
_man doTarget objNull;


while {sleep 2; _distance > 3} do {
    
    private _time        = time;
    // private _killEnemies = 
    [_man, 150] call SFSM_fnc_killNearEnemies; 
    // waitUntil {sleep 0.5; scriptDone _killEnemies;};

    private _noEnemies = time - _time < 1.1;
    private _canSprint = [_man, _movePos, 30] call SFSM_fnc_canSprint;
    if(_canSprint
    &&{_noEnemies})then{
        // private _sprint = 
        [_man, _movePos] call SFSM_fnc_sprint;
        // waitUntil {sleep 0.1; scriptDone _sprint;};
    };

    private _visible = ([(aimPos _man), _targetPos] call Tcore_fnc_visibility) > 0.8;
    private _hasMovedCloser = _distance > ((aimPos _man) distance2d _movePos);
    _distance = ((aimPos _man) distance2d _movePos);

    if!(_hasMovedCloser)
    then{
            _man doMove _movePos;
            _man doTarget objNull;
        };
    

    if(_distance < 3)                            exitWith{};
    if(time > _Timer)                             exitWith{};
    if(!alive _man)                                 exitWith{};
    if(_visible)                                 exitWith{};
    if([_man] call SFSM_fnc_isUncon)             exitWith{};
    // if([_man] call SFSM_fnc_abortSpecial)        exitWith{};


};

if(SFSM_forceDodge)
then{[_man, true] call Tcore_fnc_toggleAiMoveInhibitors};

_man setAnimSpeedCoef 1;


_man doMove (ASLToAGL getPosASL _man);
_man doFollow (leader (group _man));

true;