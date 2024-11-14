params[ 
    ["_shooter",   nil, [objNull]], // Man or vehicle whos known targets will be used.
    ["_target",    nil, [objNull]], // the target being queried
    ["_knownOnly", nil,    [true]], // if knowledge is required to return the object.
    ["_fipo",      nil, [objNull]]  // When called to calculate a target for a FIPO man
];
if(_knownOnly
&&{_shooter knowsAbout _target < 3.5})
exitWith{};

private _inValid = !([_shooter, _target] call SFSM_fnc_hostile);
if(_inValid)exitWith{};

private _action   = if(!isNil "SFSM_fnc_getAction")then{[_shooter] call SFSM_fnc_getAction}else{""};
private _startPos = eyePos _shooter;
private _adjust   = (!isNil "_fipo")&&{!("peeking" in _action)};
if(_adjust)
then{_startPos = [_startPos, _fipo]call SFSM_fnc_getFipoFirePos};

if(_shooter isKindOf "caManBase"
&&{unitPos _shooter != "DOWN"})
then{_startPos = aimPos _shooter;};

private _endPos     = eyePos _target;
private _building   = [_target] call SFSM_fnc_currentBuilding;
private _fortified  = (!isNil "_building")&&{!isNull _building};
private _ignoreList = [];

{_ignoreList pushBackUnique vehicle _x} forEach (units group _shooter);
{_ignoreList pushBackUnique vehicle _x} forEach (units group _target);

if(_fortified)then{ 
    _endPos = [_shooter, _building, 0.5] call SFSM_fnc_getHouseTargetPos;
    _target = _building;
};

private _visible    = !([_startPos, _endPos, _ignoreList] call SFSM_fnc_lineBroken);
if(_visible)   exitWith{_endPos};
if(_fortified) exitWith{}; // Exits if the target is inside a building, and there is no LOS on the building.

private _targetPos = [_shooter, _target, _ignoreList] call SFSM_fnc_getSuppressionTargetPosition;
if(isNil "_targetPos")exitWith{};

_targetPos;