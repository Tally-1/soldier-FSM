params["_movingMan", "_targetMan"];
private _destination = (getPosATLVisual _targetMan);

_movingMan doFollow _targetMan;

for "_i" from 1 to 10 do{
    if!([_movingMan] call SFSM_fnc_isRealMan)  exitWith{};
    if ([_movingMan] call SFSM_fnc_isUncon)    exitWith{};
    if (_movingMan distance _destination < 5)  exitWith{};
    if (_movingMan distance _targetMan   < 5)  exitWith{};

    if(_destination distance _targetMan > 5)then{_destination = (getPosATLVisual _targetMan);};

    private _move = [_movingMan, _destination] spawn SFSM_fnc_forceMove2;

    waitUntil {

        //abort move if target man has moved
        if(_movingMan distance _targetMan   < 5
        ||{_targetMan distance _destination > 9})then{

            [_movingMan] call SFSM_fnc_abortForcedMove;
            _movingMan doMove (getPosATLVisual _targetMan);
            sleep 2;
        };

        sleep 0.1;
        scriptDone _move;
    };
};

_movingMan doMove (getPosATLVisual _targetMan);

true;