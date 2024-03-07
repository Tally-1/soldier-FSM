// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_endPos"];
private _distanceToPos = (_man distance2D _endPos);
private _positionIsAvailable = true;

if(_distanceToPos < 2.5)
then{
        private _soldiersInPosition = count([_man, 3] call Tcore_fnc_nearSoldiers);
        if(_soldiersInPosition > 1)exitWith{_positionIsAvailable = false};
        [_man, _endPos] call SFSM_fnc_stayInCover;
    };

if!(_positionIsAvailable)exitWith{
    ["take_cover_Aborted", [_man, _endPos]] call CBA_fnc_localEvent;
    [_man, _endPos] call SFSM_fnc_forceCoverDodge;
};

_man setUnitPos "DOWN";
[_man] call SFSM_fnc_postCoverActions;

["take_cover_end", [_man, _endPos]] call CBA_fnc_localEvent;

true;