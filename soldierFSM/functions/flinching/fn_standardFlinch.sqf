// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];
private _minReactionTime = 0.1;
private _reactionTime     = 1;
private _timeReduction      = random(_man skill "spotTime");

_reactionTime = _reactionTime - _timeReduction;

if    (_reactionTime < _minReactionTime)
then{_reactionTime = _minReactionTime};

[_man, _reactionTime] spawn SFSM_fnc_execStandardFlinch;

_reactionTime;