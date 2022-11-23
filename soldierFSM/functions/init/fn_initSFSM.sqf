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


if(isNil "SFSM_Version")then{missionNamespace setVariable ["SFSM_Version", 0.403, true]};


if ( (isServer) || {( !hasInterface && { !isServer } )} ) then {
    //if (isNil "PR_Allow_HC") then { PR_Allow_HC = false; publicVariable "PR_Allow_HC"; };

/*     if (PR_Allow_HC) then {
        if (isNil "PR_HC1_Present") then { PR_HC1_Present = false; publicVariable "PR_HC1_Present"; };// Used for fn_hcTracker.sqf
        if (isNil "PR_HC2_Present") then { PR_HC2_Present = false; publicVariable "PR_HC2_Present"; };

        //[] spawn SFSM_fnc_hcTracker; // get this changed to a call
    }; */

    [] spawn SFSM_fnc_serverInit;
}; // PapaReap to let hc pass



//if(isServer)	then{[] spawn SFSM_fnc_serverInit};
if(hasInterface)then{[] spawn SFSM_fnc_initClient};



if(isNil 'ObjScan_Fnc_average')
then{
		private _noScanText = "DCO unitScanner not detected, Soldier FSM will not function properly.";
		[_noScanText] remoteExecCall ["hint", 0];
		diag_log _noScanText;
	};