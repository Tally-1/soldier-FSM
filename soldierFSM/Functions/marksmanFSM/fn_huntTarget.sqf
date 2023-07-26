params ["_marksman", "_target"];

private _firePos = [_marksman, _target] call SFSM_fnc_initHunt;
if(isNil "_firePos")exitWith{[_marksman, _target] call SFSM_fnc_endHunt;};

_marksman reveal _target;
_marksman doTarget _target;
_marksman dofire _target;

while {!([_marksman, _target] call SFSM_fnc_huntEnded)} do {
    
    private _hunt = [_marksman, _target, _firePos] spawn SFSM_fnc_huntActions;
    waitUntil {sleep 0.3; scriptDone _hunt; };

    if([_marksman, _target] call SFSM_fnc_huntEnded)exitWith{};

    private _waitTime = time +5;
    waitUntil {
        sleep 1; 
        [_marksman] call SFSM_fnc_correctTarget;
        (time > _waitTime || 
        {[_marksman, _target] call SFSM_fnc_huntEnded});
    };
};


[_marksman, _target] call SFSM_fnc_endHunt;