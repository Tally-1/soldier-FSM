/*
*  fn_hcCheck.sqf
*  Author: PapaReap
*  function name: SFSM_fnc_hcCheck
*  Called post init

*  Headless Client check
*  ver 1.0 2015-10-01
*  ver 1.1 2016-03-05 optimize for eden update
*/

if (isNil "SFSM_Allow_HC") then { SFSM_Allow_HC = false; publicVariable "SFSM_Allow_HC"; };
if (isNil "SFSM_Use_HC") then { SFSM_Use_HC = false; publicVariable "SFSM_Use_HC"; };

if (SFSM_Allow_HC) then {
    if (isServer) then {
        if (isNil "SFSM_HeadlessClients") then { SFSM_HeadlessClients = []; };
        if !(isNil "HC") then {
            if !(isNull HC) then {
                SFSM_HeadlessClients = SFSM_HeadlessClients + [HC];
                SFSM_HC_Present = true; PublicVariable "SFSM_HC_Present";
            };
        };
        if !(isNil "HC2") then {
            if !(isNull HC2) then {
                SFSM_HeadlessClients = SFSM_HeadlessClients + [HC2];
                SFSM_HC2_Present = true; PublicVariable "SFSM_HC2_Present";
            };
        };
    };

    if ( !hasInterface && { !isServer } ) then {
        if (name player == "HC") then {
            SFSM_Use_HC = true; publicVariable "SFSM_Use_HC";
            diag_log format ["*SFSM_PR* %1 SFSM_Use_HC = %2", name player, SFSM_Use_HC];
        };
        if (name player == "HC2") then {
            SFSM_Use_HC = true; publicVariable "SFSM_Use_HC";
            diag_log format ["*SFSM_PR* %1 SFSM_Use_HC = %2", name player, SFSM_Use_HC];
        };
    };

    if (isServer) then {
        if (count SFSM_HeadlessClients == 0) then {
            SFSM_Use_HC = false; publicVariable "SFSM_Use_HC";
            diag_log format ["*SFSM_PR* Server SFSM_Use_HC = %1", SFSM_Use_HC];
        } else {
            SFSM_Use_HC = true; publicVariable "SFSM_Use_HC";
            diag_log format ["*SFSM_PR* Server SFSM_Use_HC = %1", SFSM_Use_HC];
        };
    };
} else {
    if (isServer) then {
        if (isNil "SFSM_HeadlessClients") then { SFSM_HeadlessClients = []; };
        SFSM_Use_HC = false; publicVariable "SFSM_Use_HC";

        diag_log format ["*SFSM_PR* Server SFSM_Use_HC = %1", SFSM_Use_HC];
    };
};

publicVariable "SFSM_HeadlessClients";

diag_log format ["*SFSM_PR* Headless Clients = %1", SFSM_HeadlessClients];

SFSM_HcCheckComplete = true;
