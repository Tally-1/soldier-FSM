//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

//Returns an array of positions in AGL format
params["_side", "_battleField"];
private _clusterPositions = (_battlefield get "clusterPositions");
if(isNil "_clusterPositions")exitWith{[]};
private _enemyPosArr = (_clusterPositions get "east") + (_clusterPositions get "independent");
if(_side == east)       then{_enemyPosArr = (_clusterPositions get "west") + (_clusterPositions get "independent")};
if(_side == independent)then{_enemyPosArr = (_clusterPositions get "east") + (_clusterPositions get "west")};
_enemyPosArr