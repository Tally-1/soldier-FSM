//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description:  divides an arra of positions from a building in two, returning the positions of the first and second floor. If the building only has one floor, the function returns the original array.
// Params:       _buildingPositions - array of positions from a building.
// Return value: array of two arrays, the first containing the positions of the first floor, the second containing the positions of the second floor
// Example:      [(_building buildingPos -1)] call SFSM_fnc_floorPositions;

params["_buildingPositions"];
private _floors = [_buildingPositions] call SFSM_fnc_buildingFloors;
if(_floors == 1)exitWith{[_buildingPositions];};

private _avgHeight = [_buildingPositions] call Tcore_fnc_avgHeight;
private _firstFloor = _buildingPositions select {_x#2 < _avgHeight};
private _secondFloor = _buildingPositions select {_x#2 > _avgHeight};


[_firstFloor, _secondFloor];