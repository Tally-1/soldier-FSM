// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];

private _eh = 
_man addEventHandler ["AnimDone", {
    params ["_man", "_anim"];

    //men will sometimes revert to the previous position, I am using setPos in order to work around that
    private _pos = getPosASL _man;
    
    
    //get relevant data, defined in  SFSM_fnc_sprintInit
    private _segmentDone  = _anim == "AmovPercMevaSrasWrflDf";
    private _i            = _man getVariable "SFSM_SprintSegmentsDone";
    private _destination  = _man getVariable "SFSM_SprintDestination";
    private _remainDist   = _man distance2D _destination;
    
    //define exit conditions
    private _segMaxed     = _i > (_man getVariable "SFSM_maxSegments");
    private _timedOut     = time > (_man getVariable "SFSM_SprintTimer");
    private _arrived      = _remainDist < 3;
    private _dead         = !alive _man;
    private _unconscious  = [_man] call SFSM_fnc_isUncon;
    private _aborted      = [_man, "abortSprint"] call SFSM_fnc_unitData;

    //check if any of the exit conditions has been fulfilled
    private _endLoop      = _segMaxed 
                         || _timedOut 
                         || _arrived 
                         || _dead 
                         || _unconscious 
                         || _aborted;
    
    //end sprint
    if(_endLoop)exitWith{

        [_man] call SFSM_fnc_sprintVarRemoval;
        [_man] call SFSM_fnc_fixPos;
        _man doFollow (leader group _man);
        // _man setPosASL (getPosASLVisual _man);
        
        
        //end-sprint EH
        ["sprint_end", [_man, _destination]] call CBA_fnc_localEvent;
    };

    //repeat the same move again
    if(_segmentDone)then{

        private _wantedDir      = _man getDir _destination;
        private _needsAdjusting = !([(getDir _man), _wantedDir,5] call SFSM_fnc_inDirRange);
        if(_needsAdjusting)then{_man setDir _wantedDir};

        _man setVariable ["SFSM_SprintSegmentsDone", (_i+1)];
        [_man,  "AmovPercMevaSrasWrflDf"] remoteExecCall ["playMoveNow", _man];
    };

    true;

}];

_man setVariable ["SFSM_SprintEh", _eh];

true;