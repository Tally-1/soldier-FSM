// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Called when a unit has finished dodging. Reenables vanilla AI, and in some cases has him huker down.


params ["_man", "_endPos", "_timer", "_target"];
private _timer2 = time + 30;
waitUntil{
    sleep 0.5; 
    ([_man, _endPos, _timer] call SFSM_fnc_dodgeEnded
    || time > _timer2)
}; 


if(SFSM_forceDodge)
then{
    
    _man enableAI "TARGET";
    _man enableAI "AUTOCOMBAT";
    _man enableAI "AUTOTARGET";
    
    _man doTarget _target;
    
    _man setUnitPos "AUTO";
};

_man setAnimSpeedCoef 1;
[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;

//if the dodge was ended by a flinch then exit the script before setting action = "none"
//and init hunker
private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")                   exitWith{};
if(_action in ["reacting", "flinch"]) exitWith{};


_man doMove (getPos _man);

[_man, "action",     "none"]    call SFSM_fnc_unitData;


// [_man] spawn SFSM_fnc_randomHunkerInit;

true;