//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ['_building'];
private _occupants = [_building] call SFSM_fnc_unitsInBuilding;
private _positions = _building buildingPos -1;
if(count _positions < 3)exitwith{false;};
_positions = _positions select SFSM_fnc_CQBcoverPosFilter;
if(count _positions == 0)exitwith{false;};

private _available = ((count _occupants)<(count _positions));
_available;