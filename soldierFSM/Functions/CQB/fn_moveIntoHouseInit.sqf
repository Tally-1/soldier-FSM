//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _dodge = true; 

params['_man', '_building', '_dodge', '_enemyVehicle'];
private _path = [_building, true, (getPos _man)] call SFSM_fnc_buildingPath;
private _lastPathPos =(count _path)-1;
private _firstPathPos = _path#0;
private _hide = !isNil '_enemyVehicle';

//selects indoor positions only
private _positions = _path select SFSM_fnc_CQBcoverPosFilter;
if(_positions isEqualTo [])exitWith{[0,0,0];};

if(_hide)
then{
[_man, _building, _dodge, _firstPathPos, _positions, _enemyVehicle] spawn SFSM_fnc_moveIntoHouseExec;
}
else{
[_man, _building, _dodge, _firstPathPos, _positions] spawn SFSM_fnc_moveIntoHouseExec;
};



private _targetPos = _positions#((count _positions)-1);
[_man, "currentDestination", _targetPos] call SFSM_fnc_unitData;


_targetPos;