params["_man", "_captor"];
if!(random 1 < SFSM_bombOnCapture) exitWith{false;};
if ([_man] call SFSM_fnc_isPlayer) exitWith{false;};

// A variable can be inserted here(Using CBA EH) to stop the bomb from spawning.
// read "fn_canBombOnCapVars.sqf"
["pre_bomb_on_capture", [_man, _captor]] call CBA_fnc_localEvent;
private _canBomb   = [_man] call SFSM_fnc_canBombOnCapVars;
if(_canBomb isEqualTo false)exitWith{
    [[name _man, " was stopped from blowing himself up..."]] call dbgmsg;
    false;
};

private _bombType  = [_man] call SFSM_fnc_captureBombType;
if(isNil "_bombType")
exitWith{
    [[name _man, " could not blow himself up when captured"]] call dbgmsg;
    false;
};

[_man, "Not taking me alive!"] call SFSM_fnc_setAction;


if!(_bombType in ["Bomb_03_F", "GrenadeHand"])then{
    private _data = [_bombType] call ObjScan_fnc_magazineData;
    _man removeMagazine _bombType;
    _bombType = _data get "AmmoType";
};

private _bombPos   = getPosATLVisual _man;
private _explosive = createVehicle [_bombType, _bombPos];

_man setVariable       ["SFSM_capBombObj", _explosive];
_explosive setVariable ["SFSM_capBomb", true];
_explosive setDir (getDir _man);

// A variable can be inserted here to change the bomb fuse-time(Using CBA EH).
["post_bomb_on_capture", [_man, _captor, _explosive]] call CBA_fnc_localEvent;
private _fuseTime = _explosive getVariable ["SFSM_fuseTime", 1];

sleep _fuseTime;
_explosive setDamage 1;

[_man, "none"] call SFSM_fnc_setAction;
_man setVariable ["SFSM_capBombObj", nil];
[[name _man, " blew himself up with a ", _bombType]] call dbgmsg;

[_man] call SFSM_fnc_endCapture;

true;