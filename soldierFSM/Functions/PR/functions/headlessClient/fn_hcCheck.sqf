/*
*  fn_hcCheck.sqf
*  Author: PapaReap
*  Called postInit

*  Headless Client check
*  ver 1.0 2015-10-01
*  ver 1.1 2016-03-05 optimize for eden update
*/

/* if (isClass (configfile >> "CfgPatches" >> "soldierFSM")) exitWith {
    diag_log "*PR* fn_hcCheck.sqf has exited. You already have a version running on Soldier FSM.";
}; */

if ( hasInterface && { !isServer } ) exitWith {};

if (isNil "PR_Allow_HC") then { PR_Allow_HC = false; publicVariable "PR_Allow_HC"; };
if (isNil "PR_Use_HC") then { PR_Use_HC = false; publicVariable "PR_Use_HC"; };
if (isNil "PR_HC1_Present") then { PR_HC1_Present = false; publicVariable "PR_HC1_Present"; };
if (isNil "PR_HC2_Present") then { PR_HC2_Present = false; publicVariable "PR_HC2_Present"; };
if (isNil "PR_HC3_Present") then { PR_HC3_Present = false; publicVariable "PR_HC3_Present"; };
if (isNil "PR_AI_SpawnOwner") then { PR_AI_SpawnOwner = objNull; publicVariable "PR_AI_SpawnOwner"; };
// Check for existing arrays
if (isNil "noHCSwap") then { noHCSwap = []; publicVariable "noHCSwap"; };
if (isNil "hcUnits") then { hcUnits = []; publicVariable "hcUnits"; };
if (isNil "hc2Units") then { hc2Units = []; publicVariable "hc2Units"; };
if (isNil "hc3Units") then { hc3Units = []; publicVariable "hc3Units"; };
if (isNil "serverUnits") then { serverUnits = []; publicVariable "serverUnits"; };

// Check for headless clients names
if (isNil "PR_HC1") then {
    if !(isNil {(missionNameSpace getVariable "HC")}) then { PR_HC1 = missionNameSpace getVariable "HC"; }; // default name is HC
} else {
    missionNameSpace setVariable ["PR_HC1",( missionNameSpace getVariable PR_HC1),true]; publicVariable "PR_HC1";
};

if (isNil "PR_HC2") then {
    if !(isNil {(missionNameSpace getVariable "HC2")}) then { PR_HC2 = missionNameSpace getVariable "HC2"; }; // default name is HC2
} else {
    missionNameSpace setVariable ["PR_HC2",(missionNameSpace getVariable PR_HC2),true];  publicVariable "PR_HC2";
};

if (isNil "PR_HC3") then {
    if !(isNil {(missionNameSpace getVariable "HC3")}) then { PR_HC3 = missionNameSpace getVariable "HC3"; }; // default name is HC3
} else {
    missionNameSpace setVariable ["PR_HC3",(missionNameSpace getVariable PR_HC3),true];  publicVariable "PR_HC3";
};

if ( ((["PR_HeadlessClient", 0] call BIS_fnc_getParamValue) == 1) || { ( PR_Allow_HC && !((["PR_HeadlessClient", 1] call BIS_fnc_getParamValue) == 0) ) } ) then {
    if (isServer) then {
        if (isNil "PR_HeadlessClients") then { PR_HeadlessClients = []; };

        if !(isNil "PR_HC1") then {
            if !(isNull PR_HC1) then {
                PR_HeadlessClients pushBackUnique PR_HC1;
                PR_HC1_Present = true; PublicVariable "PR_HC1_Present";
            };
        };
        if !(isNil "PR_HC2") then {
            if !(isNull PR_HC2) then {
                PR_HeadlessClients pushBackUnique PR_HC2;
                PR_HC2_Present = true; PublicVariable "PR_HC2_Present";
            };
        };
        if !(isNil "PR_HC3") then {
            if !(isNull PR_HC3) then {
                PR_HeadlessClients pushBackUnique PR_HC3;
                PR_HC3_Present = true; PublicVariable "PR_HC3_Present";
            };
        };
    };

    if ( !hasInterface && { !isServer } ) then {
        if (name player == "PR_HC1") then {
            PR_Use_HC = true; publicVariable "PR_Use_HC";
            diag_log format ["*PR* %1 PR_Use_HC = %2", name player, PR_Use_HC];
        };
        if (name player == "PR_HC2") then {
            PR_Use_HC = true; publicVariable "PR_Use_HC";
            diag_log format ["*PR* %1 PR_Use_HC = %2", name player, PR_Use_HC];
        };
        if (name player == "PR_HC3") then {
            PR_Use_HC = true; publicVariable "PR_Use_HC";
            diag_log format ["*PR* %1 PR_Use_HC = %2", name player, PR_Use_HC];
        };
    };

    if (isServer) then {
        if (count PR_HeadlessClients == 0) then {
            PR_Use_HC = false; publicVariable "PR_Use_HC";
            diag_log format ["*PR* Server PR_Use_HC = %1", PR_Use_HC];
        } else {
            PR_Use_HC = true; publicVariable "PR_Use_HC";
            diag_log format ["*PR* Server PR_Use_HC = %1", PR_Use_HC];
        };
    };
} else {
    if (isServer) then {
        if (isNil "PR_HeadlessClients") then { PR_HeadlessClients = []; };
        PR_Use_HC = false; publicVariable "PR_Use_HC";

        diag_log format ["*PR* Server PR_Use_HC = %1", PR_Use_HC];
    };
};

if !(isServer) exitWith {};

publicVariable "PR_HeadlessClients";

if (PR_Use_HC) then {
    [] call SFSM_PR_hc_fnc_hcTracker;
    [] call SFSM_PR_hc_fnc_passToHCs;
    [] call SFSM_PR_hc_fnc_aiSpawner;
};

diag_log format ["*PR* Headless Clients = %1", PR_HeadlessClients];

PR_HC_CheckComplete = true;
