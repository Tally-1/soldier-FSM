// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_vehicle"];
if(typeName _vehicle != "OBJECT")exitWith{};
private _gunner = gunner _vehicle;
private _driver = driver _vehicle;
private _targetedBy = _vehicle getVariable ["targetedBy", []];
if(count _targetedBy > 0)exitWith{"car targeted, cannot reinforce"call dbgmsg; false;};
if((alive _driver) && {(!alive _gunner)})exitWith{true;};
if((!alive _driver) && {(alive _gunner)})exitWith{true;};
false;