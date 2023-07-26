// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_unitArr"];

private _sortingAlgo = { 
    private _dist = _man distance _x;
    if(_x in allPlayers)then{_dist = (_dist*0.1)};//increase probability of selection by 10x if man is a player
    _dist;
};

//selects the nearest man based on the above algorythm.(#0)
private _theChosenOne =  ([_unitArr, [], _sortingAlgo, "ASCEND"] call BIS_fnc_sortBy)#0;

_theChosenOne;