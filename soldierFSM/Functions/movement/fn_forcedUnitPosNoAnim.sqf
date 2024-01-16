params[
    ["_man",          nil,    [objNull]],
    ["_unitPos",      "DOWN",      [""]],
    ["_wait",         false,    [false]],
    ["_returnToPrev", false,    [false]]
];

private _combatMode   = combatMode _man;
private _defaultUpos  = unitPos _man;
private _wantedStance = SFSM_posToStanceMap get (toUpper _unitPos);
private _timer        = time + 2;
private _canWait      = !isNil "_wantedStance";
private _success      = true;

_man setCombatMode "BLUE";
_man setUnitPos (toUpper _unitPos);

if(_wait         isEqualTo false
&&{_returnToPrev isEqualTo false})
exitWith{
    _man setCombatMode _combatMode; 
    true;
};

if(_wait
&&{_canWait})then{ 
    waitUntil{sleep 0.1; stance _man isEqualTo _wantedStance || time > _timer};
    if(time >= _timer)then{_success = false;};
};

if(_canWait isEqualTo false && {_wait})then{[["No wanted stance found in hashmap. Pos- ", _unitPos],2] call dbgmsg;};

if(_returnToPrev)then{_man setUnitPos _defaultUpos};

_man setCombatMode _combatMode;

_success;