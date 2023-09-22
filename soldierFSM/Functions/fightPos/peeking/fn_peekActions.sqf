params["_man", "_peekTime"];
sleep 0.5;
//Man was removed from fighting position before the peeking could initiate.
if!([_man] call SFSM_fnc_inFipo)exitwith{false;};

private _target = [_man] call SFSM_fnc_getPeekTarget;

if(isNil "_target")exitWith{ 
    
    if([_man] call SFSM_fnc_fipoSuppress)exitWith{true;};
    
        [_man, "no targets...", _peekTime] spawn SFSM_fnc_flashAction;
        sleep _peekTime;
        true;
};

_peekTime = _peekTime+2;
[_man, "Engaging target"] call SFSM_fnc_setAction;


private _speed  = _man skill "aimingSpeed";
private _timer  = time+_peekTime;
private _eh     = [_man] call SFSM_fnc_fipoManFired;

_man reveal   _target;
_man doTarget _target;
_man doFire   _target;


_man setSkill ["aimingSpeed", 1];
_man disableAI "AIMINGERROR";
[_man, _timer] spawn SFSM_fnc_spamDoFire;

waitUntil{
    sleep 0.1;
    ([_man, _timer] call SFSM_fnc_peekEnded);
};

if(!isNil "_eh")then{_man removeEventHandler ["Fired", _eh];};

_man setSkill ["aimingSpeed", _speed];
_man enableAI "AIMINGERROR";

true;