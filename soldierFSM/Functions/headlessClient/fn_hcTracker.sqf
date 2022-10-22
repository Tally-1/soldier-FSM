/* fn_hcTracker.sqf
*  Author: PapaReap
*  Function Name: SFSM_fnc_hcTracker
*  Monitors the state of Headless Clients
*  ver 1.0 2016-01-31
*/

//if (PR_utility_HeadlessClient_Param == 0) exitWith {};

SFSM_TrgHC = createTrigger ["EmptyDetector", [0,0,0]];
SFSM_TrgHC setTriggerArea [3, 3, 0, false];
SFSM_TrgHC setTriggerActivation ["ANY", "PRESENT", true];
SFSM_TrgHC setTriggerStatements [
    "this && (((HC) in thisList) && !(isNil Name HC))",
    "SFSM_HC_Present = true; PublicVariable 'SFSM_HC_Present';",
    "SFSM_HC_Present = false; PublicVariable 'SFSM_HC_Present'; HC = nil; "
];

SFSM_TrgHCmove = createTrigger ["EmptyDetector", [0,0,0]];
SFSM_TrgHCmove setTriggerArea [0, 0, 0, false];
SFSM_TrgHCmove setTriggerActivation ["NONE", "PRESENT", false];
SFSM_TrgHCmove setTriggerStatements [
    "!(isNil ""HC"")",
    "SFSM_TrgHC setPos getPos HC;",
    ""
];

SFSM_TrgHC2 = createTrigger ["EmptyDetector", [0,0,0]];
SFSM_TrgHC2 setTriggerArea [3, 3, 0, false];
SFSM_TrgHC2 setTriggerActivation ["ANY", "PRESENT", true];
SFSM_TrgHC2 setTriggerStatements [
    "this && (((HC2) in thisList) && !(isNil Name HC2))",
    "SFSM_HC2_Present = true; PublicVariable 'SFSM_HC2_Present';",
    "SFSM_HC2_Present = false; PublicVariable 'SFSM_HC2_Present'; HC2 = nil; "
];

SFSM_TrgHC2move = createTrigger ["EmptyDetector", [0,0,0]];
SFSM_TrgHC2move setTriggerArea [0, 0, 0, false];
SFSM_TrgHC2move setTriggerActivation ["NONE", "PRESENT", false];
SFSM_TrgHC2move setTriggerStatements [
    "!(isNil ""HC2"")",
    "SFSM_TrgHC2 setPos getPos HC2;",
    ""
];


if !(isServer) exitWith {};

_hc   = 0;
_hc2  = 0;
_noHC = 0;

while { true } do {
    if !(isNil "HC") then {
        if ((_hc == 0) && (SFSM_HC_Present)) then {
            if !(HC in SFSM_HeadlessClients) then {
                SFSM_HeadlessClients = SFSM_HeadlessClients + [HC]; publicVariable "SFSM_HeadlessClients";
                //aiSpawnOwner = HC; publicVariable "aiSpawnOwner";
                //[logic_HQ, [_HCbackHint]] call pr_main_fnc_logicChat;
                diag_log "HC is back in action";
            };
            if !(SFSM_Use_HC) then { SFSM_Use_HC = true; publicVariable "SFSM_Use_HC"; };
            _hc = 1;
            _noHC = 1;
        } else {
            if ((_hc == 1) && !(SFSM_HC_Present)) then {
                if (SFSM_HC2_Present) then {
                    SFSM_HeadlessClients = []; publicVariable "SFSM_HeadlessClients";
                    SFSM_HeadlessClients = SFSM_HeadlessClients + [HC2]; publicVariable "SFSM_HeadlessClients";
                    //aiSpawnOwner = HC2; publicVariable "aiSpawnOwner";
                } else {
                    SFSM_HeadlessClients = [];
                    //aiSpawnOwner = objNull; publicVariable "aiSpawnOwner";
                };
                _hc = 0;
                //[logic_HQ, [_HCoutHint]] call pr_main_fnc_logicChat;
                diag_log "HC is out of action";
            };
        };
    };

    if !(isNil "HC2") then {
        if ((_hc2 == 0) && (SFSM_HC2_Present)) then {
            if !(HC2 in SFSM_HeadlessClients) then {
                SFSM_HeadlessClients = SFSM_HeadlessClients + [HC2]; publicVariable "SFSM_HeadlessClients";
                //aiSpawnOwner = HC2; publicVariable "aiSpawnOwner";
                //[logic_HQ, [_HC2backHint]] call pr_main_fnc_logicChat;
                diag_log "HC2 is back in action";
            };
            if !(SFSM_Use_HC) then { SFSM_Use_HC = true; publicVariable "SFSM_Use_HC"; };
            _hc2 = 1;
            _noHC = 1;
        } else {
            if ((_hc2 == 1) && !(SFSM_HC2_Present)) then {
                if (SFSM_HC_Present) then {
                    SFSM_HeadlessClients = []; publicVariable "SFSM_HeadlessClients";
                    SFSM_HeadlessClients = SFSM_HeadlessClients + [HC]; publicVariable "SFSM_HeadlessClients";
                    //aiSpawnOwner = HC; publicVariable "aiSpawnOwner";
                } else {
                    SFSM_HeadlessClients = [];
                    //aiSpawnOwner = objNull; publicVariable "aiSpawnOwner";
                };
                _hc2 = 0;
                //[logic_HQ, [_HC2outHint]] call pr_main_fnc_logicChat;
                diag_log "HC2 is out of action";
            };
        };
    };

    if (_noHC == 1) then {
        if ( !SFSM_HC_Present && { !SFSM_HC2_Present } ) then {
            if (SFSM_Use_HC) then {
                SFSM_Use_HC = false; publicVariable "SFSM_Use_HC";

                [] spawn SFSM_fnc_serverInit; // think we need to re-inialize groups and units ???
                //aiSpawnOwner = objNull; publicVariable "aiSpawnOwner";
                diag_log "All HC's are out of action";
                //[logic_HQ, [_HCSoutHint]] call pr_main_fnc_logicChat;
            };
            _noHC = 0;
        };
    };
    sleep 2;
};
