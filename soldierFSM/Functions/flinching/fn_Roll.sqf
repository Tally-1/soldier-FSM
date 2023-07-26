// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _dir = "random";
params ["_man", "_dir"];

if!(_man checkAIFeature "PATH")exitWith{};

private _rollMoves = ["AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDl", "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDr"];
private _rollMove  = "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDl";//roll left.

if(_dir == "right")    then{_dir = "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDr"};
if(_dir == "random")then{_rollMove = selectRandom _rollMoves};

_man playMove _rollMove;