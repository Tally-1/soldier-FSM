// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Formats the name of an explisve item to match the config name of the explosive.

params["_invName"];
private _length = count _invName;
private _cfgName = _invName select [0,(_length - 10)];
_cfgName = _cfgName insert [(count _cfgName), "F"];
_cfgName;