// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params[
        "_man", 
        "_building",
        "_buildingVarName"
    ];


[_man, "targetBuilding", _buildingVarName] call SFSM_fnc_unitData;
_building setVariable ["SFSM_explosiveRigged", true];
missionNamespace setVariable [_buildingVarName, _building];
_man setBehaviour "AWARE";
_man setCombatBehaviour "AWARE";
_man setUnitPos "UP";
_man setAnimSpeedCoef SFSM_sprintSpeed;
_man setSpeedMode "FULL";