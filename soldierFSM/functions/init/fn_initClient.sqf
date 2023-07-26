// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

waitUntil { !isNil "SFSM_overrunDistance" };

[] spawn SFSM_fnc_debugController;
[] call SFSM_fnc_3dDebug;
diag_log "**soldier FSM client loaded**";

if!(isServer)
then{[] call SFSM_fnc_logSettings};

true;