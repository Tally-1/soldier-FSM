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


if(isNil "SFSM_Version")then{missionNamespace setVariable ["SFSM_Version", 0.33, true]};


if ( (isServer) || {( !hasInterface && { !isServer } )} ) then {
    if (isNil "SFSM_Allow_HC") then { SFSM_Allow_HC = false; publicVariable "SFSM_Allow_HC"; };

    if (SFSM_Allow_HC) then {
        SFSM_HC_Present = false; publicVariable "SFSM_HC_Present"; //--- used for fn_hcTracker.sqf
        SFSM_HC2_Present = false; publicVariable "SFSM_HC2_Present"; //--- used for fn_hcTracker.sqf

        [] spawn SFSM_fnc_hcTracker;
    };

    [] spawn SFSM_fnc_serverInit;
}; // PapaReap to let hc pass



if(isServer)	then{[] spawn SFSM_fnc_serverInit};
if(hasInterface)then{[] spawn SFSM_fnc_initClient};



if(isNil 'ObjScan_Fnc_average')
then{
		private _noScanText = "DCO unitScanner not detected, Soldier FSM will not function properly.";
		[_noScanText] remoteExecCall ["hint", 0];
		diag_log _noScanText;
	};


// if (!isMultiplayer) then
// {
// 	[] spawn {
		
// 		private _text= [] call SFSM_fnc_gameLoadedWarning;
// 		hint _text;
// 	};
// }