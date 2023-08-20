/*
*  fn_aiSpawner.sqf
*  Author: PapaReap
*  function name: SFSM_PR_hc_fnc_aiSpawner

*  Spreads out spawns between server and headless clients
*  ver 1.0 2015-10-01
*  ver 1.1 2016-03-05 optimize for eden update

*  make use of hc3
*/

if !(isServer) exitWith {};

//if HC management is disabled in CBA settings, exit
waitUntil {!isNil PR_disable_HC};
if (PR_disable_HC) exitWith {}; 

if (isNil "PR_Use_HC") then { PR_Use_HC = false; publicVariable "PR_Use_HC"; };
if (isNil "PR_HC1_Present") then { PR_HC1_Present = false; publicVariable "PR_HC1_Present"; };
if (isNil "PR_HC2_Present") then { PR_HC2_Present = false; publicVariable "PR_HC2_Present"; };
if (isNil "PR_HC3_Present") then { PR_HC3_Present = false; publicVariable "PR_HC3_Present"; };

if ( PR_Use_HC && { !(isNil "PR_HC1") } && { !(isNil "PR_HC2") } ) then {
    if ( PR_HC1_Present && { PR_HC2_Present } ) then {
        if (sCntr == 0) then {
            PR_AI_SpawnOwner = PR_HC1; sCntr = 1;
        } else {
            if (sCntr == 1) then { PR_AI_SpawnOwner = PR_HC2; sCntr = 0 };
        };
    } else {
        if (PR_HC1_Present) then {
            if (sCntr == 0) then { PR_AI_SpawnOwner = PR_HC1; sCntr = 0 };
        } else {
            if (PR_HC2_Present) then {
                if (sCntr == 0) then { PR_AI_SpawnOwner = PR_HC2; sCntr = 0 };
            } else {
                if (isServer) then { PR_AI_SpawnOwner = objNull; sCntr = 0 };
            };
        };
    };
} else {
    if ( PR_Use_HC && { ( !(isNil "PR_HC1") || { !(isNil "PR_HC2") } ) } ) then {
        if (PR_HC1_Present) then {
            if (sCntr == 0) then {
                PR_AI_SpawnOwner = PR_HC1; sCntr = 0;
            } else {
                if (PR_HC2_Present) then {
                    if (sCntr == 0) then {
                        PR_AI_SpawnOwner = PR_HC2; sCntr = 0;
                    } else {
                        if (isServer) then { PR_AI_SpawnOwner = objNull; sCntr = 0 };
                    };
                };
            };
        };
    } else {
        if ( PR_Use_HC && { ( (isNil "PR_HC1") && { (isNil "PR_HC2") } ) } ) then {
            PR_AI_SpawnOwner = objNull; sCntr = 0;
        } else {
            if (isServer && !PR_Use_HC) then {
                PR_AI_SpawnOwner = objNull; sCntr = 0;
            };
        };
    };
};
publicVariable "PR_AI_SpawnOwner";

if !((["PR_DebugLog", 0] call BIS_fnc_getParamValue) == 0) then { diag_log format ["*PR* PR_AI_SpawnOwner = %1", PR_AI_SpawnOwner]; };
