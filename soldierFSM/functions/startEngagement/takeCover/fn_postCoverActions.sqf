// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];
private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
if  (isNil "_battleKey")
then{_battleKey = "";};

private _reacting    = false;
private _battleField = SFSM_battles get _battleKey;
if(!isNil "_battleField")then{ 
	_reacting = [_man, _battleField] call SFSM_fnc_reactToVehicles;
};


if!(_reacting)
then{[_man] spawn SFSM_fnc_returnToFormation;};


true;