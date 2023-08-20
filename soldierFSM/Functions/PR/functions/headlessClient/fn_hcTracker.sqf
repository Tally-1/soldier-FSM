/*
*  fn_hcTracker.sqf
*  Author: PapaReap
*  Function Name: SFSM_PR_hc_fnc_hcTracker


*  Watches for headless client connect and disconnect durning mission
*  Called from fn_hcCheck.sqf
*  Monitors the state of Headless Clients
*  ver 1.0 2016-01-31
*/

if !(isServer) exitWith {};

//if HC management is disabled in CBA settings, exit
waitUntil {!isNil PR_disable_HC};
if (PR_disable_HC) exitWith {}; 

// Setup triggers functions to watch for headless clients, connect and disconnect
pr_hc_fnc_hc1Trigger = {
    trgHC1 = createTrigger ["EmptyDetector", [0,0,0]];
    publicVariable "trgHC1";
    trgHC1 setTriggerArea [3, 3, 0, false];
    trgHC1 setTriggerActivation ["ANY", "PRESENT", true];
    trgHC1 setTriggerStatements [
        "this && { ( (PR_HC1 in thisList) && {!(isNil Name PR_HC1)} ) }",
        "PR_HC1_Present = true; PublicVariable 'PR_HC1_Present';",
        "PR_HC1_Present = false; PublicVariable 'PR_HC1_Present'; PR_HC1 = nil; "
    ];

    trgHC1move = createTrigger ["EmptyDetector", [0,0,0]];
    publicVariable "trgHC1move";
    trgHC1move setTriggerArea [0, 0, 0, false];
    trgHC1move setTriggerActivation ["NONE", "PRESENT", false];
    trgHC1move setTriggerStatements [
        "!(isNil ""PR_HC1"")",
        "trgHC1 setPos getPos PR_HC1;",
        ""
    ];
};

pr_hc_fnc_hc2Trigger = {
    trgHC2 = createTrigger ["EmptyDetector", [0,0,0]];
    publicVariable "trgHC2";
    trgHC2 setTriggerArea [3, 3, 0, false];
    trgHC2 setTriggerActivation ["ANY", "PRESENT", true];
    trgHC2 setTriggerStatements [
        "this && { ( (PR_HC2 in thisList) && {!(isNil Name PR_HC2)} ) }",
        "PR_HC2_Present = true; PublicVariable 'PR_HC2_Present';",
        "PR_HC2_Present = false; PublicVariable 'PR_HC2_Present'; PR_HC2 = nil; "
    ];

    trgHC2move = createTrigger ["EmptyDetector", [0,0,0]];
    publicVariable "trgHC2move";
    trgHC2move setTriggerArea [0, 0, 0, false];
    trgHC2move setTriggerActivation ["NONE", "PRESENT", false];
    trgHC2move setTriggerStatements [
        "!(isNil ""PR_HC2"")",
        "trgHC2 setPos getPos PR_HC2;",
        ""
    ];
};

pr_hc_fnc_hc3Trigger = {
    trgHC3 = createTrigger ["EmptyDetector", [0,0,0]];
    publicVariable "trgHC3";
    trgHC3 setTriggerArea [3, 3, 0, false];
    trgHC3 setTriggerActivation ["ANY", "PRESENT", true];
    trgHC3 setTriggerStatements [
        "this && { ( (PR_HC3 in thisList) && {!(isNil Name PR_HC3)} ) }",
        "PR_HC3_Present = true; PublicVariable 'PR_HC3_Present';",
        "PR_HC3_Present = false; PublicVariable 'PR_HC3_Present'; PR_HC3 = nil; "
    ];

    trgHC3move = createTrigger ["EmptyDetector", [0,0,0]];
    publicVariable "trgHC3move";
    trgHC3move setTriggerArea [0, 0, 0, false];
    trgHC3move setTriggerActivation ["NONE", "PRESENT", false];
    trgHC3move setTriggerStatements [
        "!(isNil ""PR_HC3"")",
        "trgHC3 setPos getPos PR_HC3;",
        ""
    ];
};

//if !(isServer) exitWith {};

PR_HC1_Status = 0;
PR_HC2_Status  = 0;
PR_HC3_Status  = 0;
PR_noHC_Status = 0;
PR_RunHC_Tracker = true;
hcTrackTimer = 60;  // sleep timer in seconds

_handle = [
    {
        params ["_args","_handle"];
        if !(PR_RunHC_Tracker) then { [_handle] call CBA_fnc_removePerFrameHandler; };

        if !(isNil "PR_HC1") then {
            if (isNil "PR_HC1_Trig") then { [] call pr_hc_fnc_hc1Trigger; PR_HC1_Trig = true; };
            if (isNil "PR_HC1_Name") then { PR_HC1_Name = format ["%1",name PR_HC1]; publicVariable "PR_HC1_Name"; };
            if ( (PR_HC1_Status == 0) && { PR_HC1_Present } ) then {
                if !(PR_HC1 in PR_HeadlessClients) then {
                    PR_HeadlessClients pushBackUnique PR_HC1;
                    publicVariable "PR_HeadlessClients";
                    PR_AI_SpawnOwner = PR_HC1; publicVariable "PR_AI_SpawnOwner";
                    _HC1backHint = format ["%1 is back in action", PR_HC1];
                    if !(isNil "pr_main_fnc_logicChat") then {
                        [logic_HQ, [_HC1backHint]] call pr_main_fnc_logicChat;
                    } else {
                        _HC1backHint remoteExec ["hint", 0];
                    };
                };
                if !(PR_Use_HC) then { PR_Use_HC = true; publicVariable "PR_Use_HC"; };
                PR_HC1_Status = 1;
                PR_noHC_Status = 1;
            } else {
                if ( (PR_HC1_Status == 1) && { !PR_HC1_Present } ) then {
                    if ( PR_HC2_Present || { PR_HC3_Present } ) then {
                        PR_HeadlessClients = [];
                        if (PR_HC2_Present) then { PR_HeadlessClients pushBackUnique PR_HC2; PR_AI_SpawnOwner = PR_HC2; };
                        if (PR_HC3_Present) then { PR_HeadlessClients pushBackUnique PR_HC3; if !(PR_HC2_Present) then { PR_AI_SpawnOwner = PR_HC3; }; };
                    } else {
                        PR_HeadlessClients = [];
                        PR_AI_SpawnOwner = objNull; 
                    };
                    publicVariable "PR_HeadlessClients";
                    publicVariable "PR_AI_SpawnOwner";
                    PR_HC1_Status = 0;
                    private _HC1outHint = format ["%1 is out of action", name PR_HC1];
                    if !(isNil "pr_main_fnc_logicChat") then {
                        [logic_HQ, [_HC1outHint]] call pr_main_fnc_logicChat;
                    } else {
                        _HC1outHint remoteExec ["hint", 0];
                    };
                };
            };
        };

        if !(isNil "PR_HC2") then {
            if (isNil "PR_HC2_Trig") then { [] call pr_hc_fnc_hc2Trigger; PR_HC2_Trig = true; };
            if (isNil "PR_HC2_Name") then { PR_HC2_Name = format ["%1",name PR_HC2]; publicVariable "PR_HC2_Name"; };
            if ( (PR_HC2_Status == 0) && { PR_HC2_Present } ) then {
                if !(PR_HC2 in PR_HeadlessClients) then {
                    PR_HeadlessClients pushBackUnique PR_HC2;
                    publicVariable "PR_HeadlessClients";
                    PR_AI_SpawnOwner = PR_HC2; publicVariable "PR_AI_SpawnOwner";
                    _HC2backHint = format ["%1 is back in action", PR_HC2_Name];
                    if !(isNil "pr_main_fnc_logicChat") then {
                        [logic_HQ, [_HC2backHint]] call pr_main_fnc_logicChat;
                    } else {
                        _HC2backHint remoteExec ["hint", 0];
                    };
                };
                if !(PR_Use_HC) then { PR_Use_HC = true; publicVariable "PR_Use_HC"; };
                PR_HC2_Status = 1;
                PR_noHC_Status = 1;
            } else {
                if ( (PR_HC2_Status == 1) && { !PR_HC2_Present } ) then {
                    if ( PR_HC1_Present || { PR_HC3_Present } ) then {
                        PR_HeadlessClients = [];
                        if (PR_HC1_Present) then { PR_HeadlessClients pushBackUnique PR_HC1; PR_AI_SpawnOwner = PR_HC1; };
                        if (PR_HC3_Present) then { PR_HeadlessClients pushBackUnique PR_HC3; if !(PR_HC1_Present) then { PR_AI_SpawnOwner = PR_HC3; }; };
                    } else {
                        PR_HeadlessClients = [];
                        PR_AI_SpawnOwner = objNull;
                    };
                    publicVariable "PR_HeadlessClients";
                    publicVariable "PR_AI_SpawnOwner";
                    PR_HC2_Status = 0;
                    private _HC2outHint = format ["%1 is out of action", PR_HC2_Name];
                    if !(isNil "pr_main_fnc_logicChat") then {
                        [logic_HQ, [_HC2outHint]] call pr_main_fnc_logicChat;
                    } else {
                        _HC2outHint remoteExec ["hint", 0];
                    };
                };
            };
        };

        if !(isNil "PR_HC3") then {
            if (isNil "PR_HC3_Trig") then { [] call pr_hc_fnc_hc3Trigger; PR_HC3_Trig = true; };
            if (isNil "PR_HC3_Name") then { PR_HC3_Name = format ["%1",name PR_HC3]; publicVariable "PR_HC3_Name"; };
            if ( (PR_HC3_Status == 0) && { PR_HC3_Present } ) then {
                if !(PR_HC3 in PR_HeadlessClients) then {
                    PR_HeadlessClients pushBackUnique PR_HC3;
                    publicVariable "PR_HeadlessClients";
                    PR_AI_SpawnOwner = PR_HC3; publicVariable "PR_AI_SpawnOwner";
                    _HC2backHint = format ["%1 is back in action", PR_HC3_Name];
                    if !(isNil "pr_main_fnc_logicChat") then {
                        [logic_HQ, [_HC2backHint]] call pr_main_fnc_logicChat;
                    } else {
                        _HC2backHint remoteExec ["hint", 0];
                    };
                };
                if !(PR_Use_HC) then { PR_Use_HC = true; publicVariable "PR_Use_HC"; };
                PR_HC3_Status = 1;
                PR_noHC_Status = 1;
            } else {
                if ( (PR_HC3_Status == 1) && { !PR_HC3_Present } ) then {
                    if ( PR_HC1_Present || { PR_HC2_Present } ) then {
                        PR_HeadlessClients = [];
                        if (PR_HC1_Present) then { PR_HeadlessClients pushBackUnique PR_HC1; PR_AI_SpawnOwner = PR_HC1; };
                        if (PR_HC2_Present) then { PR_HeadlessClients pushBackUnique PR_HC2; if !(PR_HC1_Present) then { PR_AI_SpawnOwner = PR_HC2; }; };
                    } else {
                        PR_HeadlessClients = [];
                        PR_AI_SpawnOwner = objNull;
                    };
                    publicVariable "PR_HeadlessClients";
                    publicVariable "PR_AI_SpawnOwner";
                    PR_HC3_Status = 0;
                    private _HC3outHint = format ["%1 is out of action", PR_HC3_Name];
                    if !(isNil "pr_main_fnc_logicChat") then {
                        [logic_HQ, [_HC3outHint]] call pr_main_fnc_logicChat;
                    } else {
                        _HC3outHint remoteExec ["hint", 0];
                    };
                };
            };
        };

        if (PR_noHC_Status == 1) then {
            if ( !PR_HC1_Present && { !PR_HC2_Present } && { !PR_HC3_Present } ) then {
                if (PR_Use_HC) then {
                    PR_Use_HC = false; publicVariable "PR_Use_HC";
                    PR_AI_SpawnOwner = objNull; publicVariable "PR_AI_SpawnOwner";
                    private _HCSoutHint = "All HCs are out of action";
                    if !(isNil "pr_main_fnc_logicChat") then {
                        [logic_HQ, [_HCSoutHint]] call pr_main_fnc_logicChat;
                    } else {
                        _HCSoutHint remoteExec ["hint", 0];
                    };
                };
                PR_noHC_Status = 0;
            };
        };
    },
    hcTrackTimer,
    []
] call CBA_fnc_addPerFrameHandler;
