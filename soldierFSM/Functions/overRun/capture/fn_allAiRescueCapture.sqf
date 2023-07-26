private _excluded  = [];

{
    if([_x] call SFSM_fnc_canBeCaptured)then{
        private _activeUnit = [_x, allUnits, _excluded] call SFSM_fnc_helpOrCapture;
        
        if(!isNull _activeUnit)then{
            _excluded pushBack _activeUnit;
        };
        
    };

    if(animationState _x in SFSM_panicAnimations
    &&{[_x] call SFSM_fnc_getAction isEqualTo "none"})then{
        [_x, "!PANIC!"]  call SFSM_fnc_setAction;
    };

    if(animationState _x isEqualTo "acts_jetsmarshallingemergencystop_in"
    &&{[_x] call SFSM_fnc_getAction isEqualTo "none"})then{
        [_x, "Surrendered"]  call SFSM_fnc_setAction;
    };

    
} forEach allUnits;

if(_excluded isNotEqualTo [])then{
    [[count _excluded, " units sent for capture / rescue tasks."],1] call dbgmsg;
};