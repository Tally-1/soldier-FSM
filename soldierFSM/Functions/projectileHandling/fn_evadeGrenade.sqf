// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _allowPanic = false;
params ["_grenade", "_man", "_distance", "_allowPanic"];
if!([_man] call SFSM_fnc_canRun)  exitWith{};
if ([_man] call sfsm_fnc_isPlayer)exitWith{};
private _action = [_man, "action"] call SFSM_fnc_unitData;

if("hunker" in _action)
then{[_man, nil, "Grenade landed near"] call SFSM_fnc_endHunker;};




[_man, "action", "Evading grenade"]    call SFSM_fnc_unitData;
["grenade_evade", [_man, _grenade]] call CBA_fnc_localEvent;


private _tim3r = time +5;
private _evasionDir = (_man getDir _grenade)-180;

_man setDir _evasionDir;
_man playMoveNow "AmovPercMevaSrasWrflDf";

sleep 0.621;

while{_tim3r > time}
do{
    _man playMove "AmovPercMevaSrasWrflDf";
    if (speed _man == 0
    && {_tim3r - time < 4})
    exitWith{};
    sleep 0.621;
};

if(_man Distance2d _grenade < _distance)
then{
        private _panic = [_man, true] spawn SFSM_fnc_eyelidTrench;
        waitUntil { scriptDone _panic; };
};

[_man, "action", "none"]    call SFSM_fnc_unitData;

true;