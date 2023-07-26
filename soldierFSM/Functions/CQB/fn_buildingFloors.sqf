//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: finds the amount of floors in a building.

// Params: _building: Object
// Return value: number
// Example: 
// private _positions = _building buildingPos -1;
// _exits = [_positions] call SFSM_fnc_buildingFloors;


params["_buildingPositions"];
private _floors = 1;
private _zValues = [];
{_zValues pushBack _x#2;} forEach _buildingPositions;

private _diff = (selectMax _zValues) -(selectMin _zValues);

if(_diff > 2)
then{_floors = 2};

_floors;