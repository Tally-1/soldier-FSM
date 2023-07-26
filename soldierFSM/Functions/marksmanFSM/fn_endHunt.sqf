params["_marksman", "_target"];

private _startPos   = _marksman getVariable ["SFSM_huntStartPos", getPosATL _marksman];
private _battleKey  = _marksman getVariable ["SFSM_huntBattle",   "none"];
private _combatMode = _marksman getVariable ["SFSM_combatMode",   "YELLOW"];
private _eh         = _marksman getVariable ["SFSM_fireEh",       -1];
private _PreyEh     = _marksman getVariable ["SFSM_myPreyEh",     -1];
private _returning  = [_marksman, _battleKey, _startPos] call SFSM_fnc_marksmanReturn;

_marksman removeEventHandler ["Fired", _eh];
_marksman setUnitCombatMode _combatMode;

if(!isNil "_target")
then{
    _target setVariable ["SFSM_myAssasin", nil, true];
    _target removeEventHandler ["HitPart", _PreyEh];
};

_marksman setVariable    ["SFSM_myTarget",     nil, true];
_marksman setVariable    ["SFSM_myFirePos",    nil, true];
_marksman setVariable    ["SFSM_combatMode",   nil, true];
_marksman setVariable    ["SFSM_fireEh",       nil, true];
_marksman setVariable    ["SFSM_myPreyEh",     nil, true];
_marksman setVariable    ["SFSM_huntStartPos", nil, true];
_marksman setVariable    ["SFSM_huntBattle",   nil, true];

_marksman enableAI "TARGET";
_marksman enableAI "AUTOCOMBAT";
_marksman enableAI "AUTOTARGET";


[_marksman, "huntEnded", time]      call SFSM_fnc_unitData;
if(_target getVariable ['SFSM_killer', objNull] isEqualTo _marksman)then{
    [_marksman, "Hunt successful!"]     spawn SFSM_fnc_flashAction;
};

if(_returning)exitWith{};

[_marksman, "action", "none"] call SFSM_fnc_unitData;
[_marksman, "Hunt ended"]     spawn SFSM_fnc_flashAction;

true;