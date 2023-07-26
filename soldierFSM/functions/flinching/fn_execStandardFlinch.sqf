// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: changes the stance of a man as a reaction to incoming fire.

params ['_man', '_reactionTime'];
sleep _reactionTime;

[_man, "action", "flinch"] call SFSM_fnc_unitData;

switch (stance _man) do
    {
        case "STAND" :    { _man setUnitPos "MIDDLE" };
        case "CROUCH":     { _man setUnitPos "DOWN"  };
        case "PRONE" :     { [_man] spawn SFSM_fnc_proneFlinch};
    };