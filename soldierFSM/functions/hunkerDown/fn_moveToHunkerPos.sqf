// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_pos", "_battleField"];
private _timer = time + 60;

[_man, "action", "move to hunker pos"]     call SFSM_fnc_unitData;

private _script = [_man, _pos, 20] spawn SFSM_fnc_forceMove2;
waitUntil{scriptDone _script};
private _distToPos = (eyePos _man) distance2d _pos;
if(_distToPos > 1)
then{
     while {_distToPos > 1} do {

        _script = [_man, _pos, 3] spawn SFSM_fnc_forceMove2; 
        waitUntil{scriptDone _script};

        _distToPos = (eyePos _man) distance2d _pos;

        private _text = ["move to hunker pos ", _distToPos, "m left"] joinString "";

        [_man, "action", _text]     call SFSM_fnc_unitData;


        if(!alive _man)exitWith{};
        if(time>_timer)exitWith{};
        if(isNil "_battleField")exitWith{};
        
        sleep 3;
     };
};
true;