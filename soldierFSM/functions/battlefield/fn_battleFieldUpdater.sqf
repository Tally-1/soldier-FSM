//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: This script is the main loop of the battlefield. It is called by the SFSM_fnc_battlefieldPostInit and runs until the battle is over.

// Params: [_battleField:hashmap]

// Return value: true

// Example: [_battleField] spawn SFSM_fnc_battleFieldUpdater;


params ['_battleField'];

while {!isNil "_battleField"} 
do     {
        
        

        private _ended = [_battleField] call SFSM_fnc_updateBattlefield;
        if(isNil "_ended")exitWith{};
        if(_ended)exitWith{};

        // _battlefield set ["currentAction",    "Medical actions"];
        // private _script = [_battleField] spawn SFSM_fnc_battleFieldMedical;
        // waitUntil {
        //     private _finito = scriptDone _script;
        //     if(isNil "_finito")exitWith{true;};
        //     _finito; 
        // };
        

        private _script = [_battleField] spawn SFSM_fnc_updateGrid;
        waitUntil {
            private _finito = scriptDone _script;
            if(isNil "_finito")exitWith{true;};
            _finito; 
        };

        private _script = [_battleField] spawn SFSM_fnc_battleFieldCQB;
        waitUntil {
            private _finito = scriptDone _script;
            if(isNil "_finito")exitWith{true;};
            _finito; 
        };

        _battlefield set ["currentAction",    "Assigning vehicles"];
        private _script = [_battleField] spawn SFSM_fnc_hijackAllVehicles;
        waitUntil {
            private _finito = scriptDone _script;
            if(isNil "_finito")exitWith{true;};
            _finito; 
        };

        
        _battlefield set ["currentAction",    "Reinforcing vehicles"];
        private _script = [_battleField] spawn SFSM_fnc_reinforceVehicles;
        waitUntil {
            private _finito = scriptDone _script;
            if(isNil "_finito")exitWith{true;};
            _finito; 
        };

        // _battlefield set ["currentAction",    "Medical actions"];
        // private _script = [_battleField] spawn SFSM_fnc_battleFieldMedical;
        // waitUntil {
        //     private _finito = scriptDone _script;
        //     if(isNil "_finito")exitWith{true;};
        //     _finito; 
        // };

        _battlefield set ["currentAction",    "none"];

        sleep SFSM_BattleUpdateSec;
    };

true;