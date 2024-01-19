//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: gets infantry units inside a building

// Params: [_building:object, _excludedSide:side]

// Return value: array of units

// Example: [player, west] call SFSM_fnc_unitsInBuilding

params["_building", "_excludedSide"];
private _shape = [_building] call Tcore_fnc_object3DShape;
private _size = selectMax [(_shape get "width"),(_shape get "length")];
private _units = (_building nearEntities ["CAManBase", _size]) 
        select {[_x] call SFSM_fnc_functionalMan 
		&&     {insideBuilding _x isEqualTo 1}};

if(!isNil "_excludedSide")
then{_units = _units select {side _x != _excludedSide}};

_units;

