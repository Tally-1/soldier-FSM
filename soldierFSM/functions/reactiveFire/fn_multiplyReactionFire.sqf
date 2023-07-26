// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_unit", "_muzzle", "_weapon"];

private _action = [_unit, "action"] call SFSM_fnc_unitData;
private _fireActions = ["return fire", "return direct fire"];
if(_action in _fireActions)then{[_unit, _muzzle, _weapon] spawn SFSM_fnc_multiplyRF};
true;