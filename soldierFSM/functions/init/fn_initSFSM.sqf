// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

if(is3DEN)exitWith{};



if((!isNil "SFSM_disableSoldierFSM")
&&{SFSM_disableSoldierFSM})
exitWith{
            ["SOLDIER FSM Has been disabeled!!", true, true, 2, "--SFSM ShutDown--"] 
            call Tcore_fnc_debugMessage;
        };

//for ease of writing I have shortened the name of the debugMessage function.
if(isNil "dbgmsg")
then{dbgmsg = SFSM_fnc_debugMessage};


if(isNil "SFSM_Version")then{missionNamespace setVariable ["SFSM_Version", 1.33, true]};

private _headlessClient = hasInterface isEqualTo false && {isServer isEqualTo false;};

if(isServer 
||{_headlessClient}) 
then{[] spawn SFSM_fnc_serverInit}; // PapaReap: to let HC pass.

if(hasInterface)then{[] spawn SFSM_fnc_initClient;};


if(isNil 'ObjScan_Fnc_average')
then{
    private _noScanText = "DCO unitScanner not detected, Soldier FSM will not function properly.";
    [_noScanText] remoteExecCall ["hint", 0];
    diag_log _noScanText;
};