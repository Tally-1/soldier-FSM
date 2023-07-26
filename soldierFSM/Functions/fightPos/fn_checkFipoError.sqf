params["_man", "_action", "_fipoGotten"];

if(_fipoGotten && {_man checkAIFeature "Path"})               exitWith{true;};
if(_action == "In cover" && {! _fipoGotten})                  exitWith{true;};
if(_action == "In cover" && {_man checkAIFeature "Path"})     exitWith{true;};
if(_fipoGotten && {_action == "Moving to fighting position"}) exitWith{true;};

false;