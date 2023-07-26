params["_man", "_ATLPos"];
private _timer       = time + 20;
private _distance    = round((getPosATL _man) distance _ATLPos);
private _keepMoving  = _distance > 1.1;
private _failedMoves = 0;
private _isLeader    = leader group _man isEqualTo _man;

[_man, false] call Tcore_fnc_toggleAiMoveInhibitors;
[_man, "forcedMovement", true] call SFSM_fnc_unitData;

while{_keepMoving}do{

    if(time > _Timer)                                    exitWith{_keepMoving = false;};
    if!([_man, true] call SFSM_fnc_canRun)               exitWith{_keepMoving = false;};
    if([_man, "abortForcedMove"] call SFSM_fnc_unitData) exitWith{_keepMoving = false;};

    private _hasMovedCloser = _distance > ((getPosATL _man) distance _ATLPos);

    if!(_hasMovedCloser)
    then{
            // _man setDestination [_ATLPos, "DoNotPlanFormation", true];
            _man doMove _ATLPos;
            _man moveTo _ATLPos;
            _man doTarget objNull;
            _man disableAI "AUTOTARGET";
            _man setCombatBehaviour "AWARE";
            _failedMoves = _failedMoves+1;
        };

    _distance = ((getPosATL _man) distance _ATLPos);
    if(_distance < 1.1) exitWith{_keepMoving = false};

    if(_failedMoves > 10
    &&{! _isLeader})then{
        [_man] call SFSM_fnc_resetBrain;
        _failedMoves = -30;
    };

    sleep 1;
};


[_man, true] call Tcore_fnc_toggleAiMoveInhibitors;
[_man, "forcedMovement", false] call SFSM_fnc_unitData;

_man doFollow (leader (group _man));
_man moveTo _ATLPos;
_man doMove _ATLPos;
_man doTarget objNull;

true;