//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: finds exits in a building

// Params: _building: Object - the building to find exits in

// Return value: Array - an array of positions

// Example: _exits = [cursorObject] call SFSM_fnc_buildingExits;

params ["_building"];
private _exits = [];
private _maxZ = 0.8;
for "_i" from 0 to 100 
do{
    private _pos = (_building buildingExit _i);
    if(_pos isEqualTo [0,0,0])exitWith{};
    private _valid = (_pos#2<_maxZ &&{_pos#2>(0-_maxZ)});
    if(_valid)then{_exits pushBackUnique _pos;};
    
};

_exits;