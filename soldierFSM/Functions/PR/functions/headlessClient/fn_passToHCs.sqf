/*
*  fn_passToHCs.sqf
*  Author: PapaReap
*  Function Name: SFSM_PR_hc_fnc_passToHCs

*  Load balances ai to headless clients
*  Name your headlessClients: HC,HC2,HC3 for example. Can run with 1-3 headlessClients if preferred.
*  If not running from a call function, then add execVM "scripts\PR\headlessClient\passToHCs.sqf"; to you init.sqf should be placed high i.e. a priority initialization 
*/

if !(isServer) exitWith {};

//if HC management is disabled in CBA settings, exit
waitUntil {!isNil PR_disable_HC};
if (PR_disable_HC) exitWith {}; 

if ( ((["PR_HeadlessClient", 1] call BIS_fnc_getParamValue) == 0) || { ( !PR_Allow_HC && ((["PR_HeadlessClient", 0] call BIS_fnc_getParamValue) == 0) ) } ) exitWith {};

if !(isNil "PR_PTHCs") exitWith {};
PR_PTHCs = true;
if !(isNil "usePassToHCs") then { if !(usePassToHCs) exitWith {}; };

diag_log "passToHCs: Started";

PR_RunPassToHCs = true; publicVariable "PR_RunPassToHCs";
rebalanceTimer = 60;  // Rebalance sleep timer in seconds
//cleanUpThreshold = 30; // Threshold of number of dead bodies + destroyed vehicles before forcing a clean up
prTestHc=PR_HC1;

// Determine first headlessClient to start with
private _currentHC = 0;
if ( !(isNil "PR_HC1") && { !(isNull PR_HC1) } ) then {
    _currentHC = 1;
} else {
    if ( !(isNil "PR_HC2") && { !(isNull PR_HC2) } ) then {
        _currentHC = 2;
    } else {
        if ( !(isNil "PR_HC3") && { !(isNull PR_HC3) } ) then {
            _currentHC = 3;
        };
    };
};
missionNamespace setVariable ["PR_CurrentHC",_currentHC];
//localNamespace setVariable ["PR_CurrentHC",_currentHC];

// Add CBA_fnc_addPerFrameHandler
_handle = [
    {
        params ["_args","_handle"];
        if !(PR_RunPassToHCs) then { [_handle] call CBA_fnc_removePerFrameHandler; };

        //[] call pr_hc_fnc_aiTransfer;

        private _HC_ID = -1;
        private _HC2_ID = -1;
        private _HC3_ID = -1;
        private _textActive = "passToHCs: Found %1 with Client ID %2";
        private _textWarn = "passToHCs: [WARN] %1 disconnected";
        private _hcActive = if ( ( !isNil "PR_HC1" && { !isNull PR_HC1 } ) && { (owner PR_HC1 > 2) } ) then {
            _HC_ID = owner PR_HC1; diag_log format [_textActive,name PR_HC1, _HC_ID]; true
        } else {
            if ( !isNil "PR_HC1" && { isNull PR_HC1 } ) then {
                diag_log format [_textWarn,name PR_HC1]; false
            } else {
                false
            };
        };
        private _hc2Active = if ( ( !isNil "PR_HC2" && { !isNull PR_HC2 } ) && { (owner PR_HC2 > 2) } ) then {
            _HC2_ID = owner PR_HC2; diag_log format [_text,name PR_HC2, _HC2_ID]; true
        } else {
            if ( !isNil "PR_HC2" && { isNull PR_HC2 } ) then {
                diag_log format [_textWarn,name PR_HC2]; false
            } else {
                false
            };
        };
        private _hc3Active = if ( ( !isNil "PR_HC3" && { !isNull PR_HC3 } ) && { (owner PR_HC3 > 2) } ) then {
            _HC3_ID = owner PR_HC3; diag_log format [_text,name PR_HC3, _HC3_ID]; true
        } else {
            if ( !isNil "PR_HC3" && { isNull PR_HC3 } ) then {
                diag_log format [_textWarn,name PR_HC3]; false
            } else {
                false
            };
        };

        // Do not process any transfer if no headlessClients available
        if ( _hcActive || { _hc2Active } || { _hc3Active } ) then {

            // Gather up all the arrays to cleanup dead and null objects
            private _deadArray = [];
            {
                if !(_x in _deadArray) then {
                    _deadArray pushBackUnique _x;
                };
            } forEach allDead;
            private _deadCount = (count _deadArray);
            diag_log format ["passToHCs: Dead count on map = %1", _deadCount];

            _preCount1 = 0;
            _postCount1 = 0;
            _preCount1 = count noHCSwap;
            noHCSwap = noHCSwap - _deadArray;
            noHCSwap = noHCSwap - [objNull];
            _postCount1 = _preCount1 - (count noHCSwap);
            diag_log format ["passToHCs: Clean-up of noHCSwap, removed objects = %1", _postCount1];

            if (_hcActive) then {
                private _preCount2 = 0;
                private _postCount2 = 0;
                _preCount2 = count hcUnits;
                hcUnits = hcUnits - _deadArray;
                hcUnits = hcUnits - [objNull];
                _postCount2 = _preCount2 - (count hcUnits);
                diag_log format ["passToHCs: Clean-up of %1, removed objects = %2",name PR_HC1,_postCount2];//text cleanup
            } else {
                hcUnits = [];
            };

            if (_hc2Active) then {
                private _preCount3 = 0;
                private _postCount3 = 0;
                _preCount3 = count hc2Units;
                hc2Units = hc2Units - _deadArray;
                hc2Units = hc2Units - [objNull];
                _postCount3 = _preCount3 - (count hc2Units);
                diag_log format ["passToHCs: Clean-up of %1, removed objects = %2",name PR_HC2,_postCount3];//text cleanup
            } else {
                hc2Units = [];
            };

            if (_hc3Active) then {
                _preCount4 = 0;
                _postCount4 = 0;
                _preCount4 = count hc3Units;
                hc3Units = hc3Units - _deadArray;
                hc3Units = hc3Units - [objNull];
                _postCount4 = _preCount4 - (count hc3Units);
                diag_log format ["passToHCs: Clean-up of %1, removed objects = %2", name PR_HC3,_postCount4];//text cleanup
            } else {
                hc3Units = [];
            };

            _preCount5 = 0;
            _postCount5 = 0;
            _preCount5 = count serverUnits;
            serverUnits = serverUnits - _deadArray;
            serverUnits = serverUnits - [objNull];
            _postCount5 = _preCount5 - (count serverUnits);
            diag_log format ["passToHCs: Clean-up of Server, removed objects = %1", _postCount5];

            // Pass the AI
            private _numTransfered = 0;

            // Do not enable load balancing unless more than one headlessClient is present
            private _loadBalance = false;

            // Check to auto enable Round-Robin load balancing strategy
            if ( (_hcActive && { _hc2Active }) || { (_hcActive && { _hc3Active })} || { (_hc2Active && { _hc3Active }) } ) then {
                _loadBalance = true;
                diag_log "passToHCs: Starting load-balanced transfer of AI groups to HCs";
            } else {
                private _name = "";
                if (_hcActive) then { _name = name PR_HC1; } else { if (_hc2Active) then { _name = name PR_HC2; } else { _name = name PR_HC3; }; };
                diag_log format ["passToHCs: Starting transfer of AI groups to %1",_name];
            };

            // Get the current headlessClient
            //private _currentHC = localNamespace getVariable "PR_CurrentHC";
            private _currentHC = missionNamespace getVariable "PR_CurrentHC";

            // Swap available units in groups, if possible
            {
                private _swap = true;

                // If a player is in this group, or units already in existing array, don't swap to an headlessClient
                { if (isPlayer _x) then { _swap = false; }; } forEach (units _x);
                { if (_x in noHCSwap) then { _swap = false; }; } forEach (units _x);
                { if (_x in hcUnits) then { _swap = false; }; } forEach (units _x);
                { if (_x in hc2Units) then { _swap = false; }; } forEach (units _x);
                { if (_x in hc3Units) then { _swap = false; }; } forEach (units _x);
                { if (_x in serverUnits) then { _swap = false; }; } forEach (units _x);
                { if (typeOf driver _x == "B_UAV_AI") then { _swap = false; }; } forEach (units _x);

                // If load balance enabled, round robin between the headlessClients - else pass all to one headlessClient if it passes _swap test
                if ( _swap ) then {
                    private _canSwitch = false;

                    // Get group waypoints
                    private _wpArray = waypoints _x;
                    _x setVariable ["PR_AI_Waypoints",_wpArray,true];

                    private _text = "passToHCs: [ERROR] No Valid HCs to pass to.  currentHC = %1";
                    if ( _loadBalance ) then {
                        switch (_currentHC) do {
                            case 1: {
                                _canSwitch = _x setGroupOwner _HC_ID;
                                if (_canSwitch) then {
                                    if (_hc2Active) then { _currentHC = 2; } else { if (_hc3Active) then { _currentHC = 3; }; };
                                    { hcUnits pushBackUnique _x; } forEach (units _x);
                                };
                            };
                            case 2: {
                                _canSwitch = _x setGroupOwner _HC2_ID;
                                if (_canSwitch) then {
                                    if (_hc3Active) then { _currentHC = 3; } else { if (_hcActive) then { _currentHC = 1; }; };
                                    { hc2Units pushBackUnique _x; } forEach (units _x);
                                };
                            };
                            case 3: {
                                _canSwitch = _x setGroupOwner _HC3_ID;
                                if (_canSwitch) then {
                                    if (_hcActive) then { _currentHC = 1; } else { if (_hc2Active) then { _currentHC = 2; }; };
                                    { hc3Units pushBackUnique _x; } forEach (units _x);
                                };
                            };
                            default { diag_log format [_text, _currentHC]; };
                        };
                    } else {
                        switch (_currentHC) do {
                            case 1: { _canSwitch = _x setGroupOwner _HC_ID; if (_canSwitch) then { { hcUnits pushBackUnique _x; } forEach (units _x); }; };
                            case 2: { _canSwitch = _x setGroupOwner _HC2_ID; if (_canSwitch) then { { hc2Units pushBackUnique _x; } forEach (units _x); }; };
                            case 3: { _canSwitch = _x setGroupOwner _HC3_ID; if (_canSwitch) then { { hc3Units pushBackUnique _x; } forEach (units _x); }; };
                            default { diag_log format [_text, _currentHC]; };
                        };
                    };
                    //localNamespace setVariable ["PR_CurrentHC",_currentHC];
                    missionNamespace setVariable ["PR_CurrentHC",_currentHC];

                    // If the transfer was successful, count it for accounting and diagnostic information
                    if (_canSwitch) then { _numTransfered = _numTransfered + 1; };
                };
            } forEach (allGroups);

            publicVariable "noHCSwap";
            publicVariable "hcUnits";
            publicVariable "hc2Units";
            publicVariable "hc3Units";
            publicVariable "serverUnits";

            if (_numTransfered > 0) then {
                // More accounting and diagnostic information
                diag_log format ["passToHCs: Transfered %1 AI groups to HCs", _numTransfered];

                private _numHC = 0;
                private _numHC2 = 0;
                private _numHC3 = 0;

                {
                    switch (owner ((units _x) select 0)) do {
                        case _HC_ID: { _numHC = _numHC + 1; };
                        case _HC2_ID: { _numHC2 = _numHC2 + 1; };
                        case _HC3_ID: { _numHC3 = _numHC3 + 1; };
                    };
                } forEach (allGroups);

                private _text = "passToHCs: %1 AI groups currently on %2";
                if (_numHC > 0) then { diag_log format [_text, _numHC,name PR_HC1]; };
                if (_numHC2 > 0) then { diag_log format [_text,_numHC2,name PR_HC2]; };
                if (_numHC3 > 0) then { diag_log format [_text,_numHC3,name PR_HC3]; };

                diag_log format ["passToHCs: %1 AI groups total across all HCs", (_numHC + _numHC2 + _numHC3)];
            } else {
                diag_log "passToHCs: No rebalance or transfers required this round";
            };
        } else {
            diag_log "passToHCs: No Active HCs present";
        };



        /*
        // Force clean up dead bodies and destroyed vehicles
        if (count allDead > cleanUpThreshold) then {
            private _numDeleted = 0;
            {
                deleteVehicle _x;
                _numDeleted = _numDeleted + 1;
            } forEach allDead;

            diag_log format ["passToHCs: Cleaned up %1 dead bodies/destroyed vehicles", _numDeleted];
        };
        */
    },
    rebalanceTimer, // Rebalance every rebalanceTimer seconds to avoid hammering the server
    []
] call CBA_fnc_addPerFrameHandler;
