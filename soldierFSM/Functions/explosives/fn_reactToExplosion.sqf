// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_launchPos", "_impactPos", "_shooter"];


if!([_man] call SFSM_fnc_availableAiSoldier) exitWith{false;};

"reacting" call dbgmsg;
private _minRadius = 10;
private _flinchRadius = 60;
private _notInBattle = (([_man, "currentBattle"] call SFSM_fnc_unitData) isEqualTo "none");
private _distanceToImpact = _impactPos distance2D _man;
private _outOfMinRad      = _distanceToImpact > _minRadius;
private _flinch           = ((_distanceToImpact < _flinchRadius) && {_outOfMinRad});
private _takeCover        = (_notInBattle && {_outOfMinRad && {! _flinch}});

if (_flinch) 
then {[_man, _launchPos, _shooter] spawn SFSM_fnc_bigFlinchCover;};


if(_takeCover)
then{[_man, _launchPos] call SFSM_fnc_eventTriggeredCover;};

true;