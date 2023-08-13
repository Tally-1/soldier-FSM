// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _radius = SFSM_DodgeDistance;
params ["_man", '_searchPos', '_radius'];

private _battlefield = [_man] call SFSM_fnc_getBattlefield;
if(isNil "_battlefield")exitWith{};
if(isNil '_searchPos')then{_searchPos = getPos _man};


private _side              = side _man;
private _coverPositions    = [];
private _cPosData          = _battlefield get "coverPositions";
// private _fightingPositions = (SFSM_fipositions apply {getPosATLVisual _x}) inAreaArray [_searchPos, _radius, _radius];
// private _fiposPresent      = _fightingPositions isNotEqualTo [];

// if(_fiposPresent)exitWith{
//     private _nearest = [_searchPos, _fightingPositions] call SFSM_fnc_getNearest;
//     _nearest;
// };

if(isNil '_cPosData')   exitWith{[_man, _radius] call Tcore_fnc_coverPosSimple;};

switch (_side) do {
    case east:             { _coverPositions =  _cPosData get "east"; };
    case west:             { _coverPositions =  _cPosData get "west"; };
    case independent:      { _coverPositions =  _cPosData get "independent"; };
};

if(isNil '_coverPositions')exitWith{[_man, _radius] call Tcore_fnc_coverPosSimple};

_coverPositions = (_coverPositions inAreaArray [_searchPos, _radius, _radius]);


private _coverPos = [_man, _coverPositions, _battlefield] call SFSM_fnc_selectCoverPos;

if(isNil '_coverPos')exitWith{[_man, _radius] call Tcore_fnc_coverPosSimple;};

_coverPos 