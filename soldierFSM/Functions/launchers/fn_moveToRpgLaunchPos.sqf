params[
    ["_man",       nil, [objNull]],
    ["_building",  nil, [objNull]],
    ["_launchPos", nil,      [[]]]
];

if([_man, _building] call SFSM_fnc_atValidRpgFirePos)exitWith{true;};

private _timeLimit   = time + 30;
private _buildingPos = [_building] call SFSM_fnc_buildingCenterPosASL;
private _moveEnded   = false;
private _move = 
[
    _man,      //unit 
    _launchPos,//position 
    30,        //timeout (optional)
    2          //minimum distance to position in order to complete move. (optional)

] spawn SFSM_fnc_forceMove2;

waitUntil{
    if(_moveEnded)exitWith{true;};
    
    sleep 1;

    _moveEnded = [_move, _timeLimit, _man, _building] call SFSM_fnc_whileRpgMove;
    _moveEnded;
};

true;