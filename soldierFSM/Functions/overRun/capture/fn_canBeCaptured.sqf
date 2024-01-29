params["_man"];
private _group       = group _man;
private _allowedType = SFSM_captureTargets;
private _isPlayer    = _man in allPlayers;
private _isAi        = _isPlayer isEqualTo false;

if (isNull _group)                               exitWith{false;};
if!(_man isKindOf "CAManBase")                   exitWith{false;};
if (side _group isEqualTo sideLogic)             exitWith{false;};
if (isObjectHidden _man)                         exitWith{false;};
if!([_man] call SFSM_fnc_unconSurrPan)           exitWith{false;};
if (_allowedType isEqualTo "nobody")             exitWith{false;};
if (_allowedType isEqualTo "ai" && {_isPlayer})  exitWith{false;};
if (_allowedType isEqualTo "players" && {_isAi}) exitWith{false;};
// if (_allowedType isEqualTo "all")                exitWith{true;};


true;