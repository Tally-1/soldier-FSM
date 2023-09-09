//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: This script is used to revive units on the battlefield. It is called by the SFSM_fnc_initBattleField script. It is not intended to be called directly.

// Params: [_battleField] - (hashmap)

// Return value: true

// Example: [_battleField] spawn SFSM_fnc_battleFieldMedicLoop;


params["_battleField"];
if!(SFSM_aceLoaded)exitWith{["Ace not loaded, SFSM revival deactivated",2] call dbgmsg;};
["Starting med-loop",2] call dbgmsg;

while {!isNil "_battleField"} do {
    // private _script = 
    [_battleField] call SFSM_fnc_battleFieldMedical;
    // waitUntil {
    //         sleep 1;
    //         private _finito = scriptDone _script;
    //         if(isNil "_finito")exitWith{true;};
    //         _finito; 
    // };

    private _units             = missionNamespace getVariable (_battlefield get "units");
    if(isNil "_units")exitWith{};
    
    sleep 10;
};

["Ending med-loop",2] call dbgmsg;

true;