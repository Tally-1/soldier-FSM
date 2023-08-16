// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: 3D feedback loop that draws markers on the battlefield, and displays information about the current state of the game.
//              This is a debug tool, and should not be used in a production environment.

if(!isnil "3DmarkersSFSM")exitWith{};
3DmarkersSFSM     = true;
SFSM_bullets      = [];
SFSM_trajectories = [];
SFSM_3Dsectors    = [];

if(SFSM_DebugType isEqualTo "always")  then {SFSM_Debugger = true;};
if(SFSM_DebugType isEqualTo "curator") then {SFSM_Debugger = true;};
if(SFSM_DebugType isEqualTo "never")   then {SFSM_Debugger = false;};


addMissionEventHandler ["Draw3D", {
if(SFSM_Debugger)
then{
        [] call SFSM_fnc_man3dInfo;
        [] call SFSM_fnc_battlefield3d;
        [] call SFSM_fnc_drawBullets;
        [] call SFSM_fnc_custom3Dmarkers;
        [] call SFSM_fnc_drawAllTrajectories;
        [] call SFSM_fnc_drawFiPositions;     
        [] call SFSM_fnc_drawAllAimLines;  
        [] call SFSM_fnc_draw3Dsectors;     
}}];


if(SFSM_Debugger)then{

waituntil {!isNull (findDisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown", {

    if (inputAction "CuratorInterface" > 0) then
    {[] spawn SFSM_fnc_debugCuratorInterface;};
    false;
}];

};