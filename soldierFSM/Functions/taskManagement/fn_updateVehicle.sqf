// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ['_vehicle'];


private _battleKey = ([_vehicle, "currentBattle"] call SFSM_fnc_vehicleData);
if(isNil "_battleKey")exitWith{};
private _battleField = SFSM_battles get _battleKey;
if(isNil "_battleField")exitWith{[_vehicle, "hiddenPos", []] call SFSM_fnc_vehicleData;};
if!(_battleField get "gridLoaded")exitWith{};

private _grid = missionNamespace getVariable (_battleField get "grid");
        _grid = _grid get "gridPositions";
private _vPos = getPos _vehicle;
private _hiddenPositions = [_vPos, _grid, _vehicle, 2, true] call Tcore_fnc_visibleFromPositions;

[_vehicle, "hiddenPos", _hiddenPositions] call SFSM_fnc_vehicleData;

// private _txt = ['hidden positions = ', (count _hiddenPositions)] joinString '';
// _txt call dbgmsg;