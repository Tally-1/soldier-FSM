private _dir = "random";
params ["_man", "_dir"];

if!(_man checkAIFeature "PATH")exitWith{};

private _rollMoves = ["AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDl", "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDr"];
private _rollMove  = "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDl";//roll left.

if(_dir == "right")	then{_dir = "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDr"};
if(_dir == "random")then{_rollMove = selectRandom _rollMoves};

_man playMove _rollMove;