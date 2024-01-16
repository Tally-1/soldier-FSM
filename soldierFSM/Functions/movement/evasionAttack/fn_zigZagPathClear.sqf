params[
    ["_man",    nil, [objNull]],
    ["_target", nil, [objNull]]
];
private _startPos = aimPos _man;
private _leftPos  = _man modelToWorldWorld [-3,0,1];
private _rightPos = _man modelToWorldWorld [3,0,1];

if([_startPos, _rightPos] call SFSM_fnc_lineBroken)exitWith{false;};
if([_startPos, _leftPos]  call SFSM_fnc_lineBroken)exitWith{false;};

true;