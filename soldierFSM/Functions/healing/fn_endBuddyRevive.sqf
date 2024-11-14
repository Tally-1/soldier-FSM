// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description:ends the buddy revive action.

// Return value: none

// Example: [_healer, _wounded, true] call SFSM_fnc_endBuddyHeal;

params[
    "_healer",      // Object(man): the healer
    "_unconscious", // Object(man): the unconscious
    "_success"      // Boolean: true if the heal was successful, false if not
];
private _fipo         = _healer getVariable "SFSM_myFipo";
private _returnToFipo = !isNil "_fipo";
private _status       = "successful!";

if!(_success)then{_status = "failed!";};

private _actionText = ["revive ", _status] joinString "";
[_healer,      _actionText, 2] spawn SFSM_fnc_flashAction;
[_unconscious, _actionText, 2] spawn SFSM_fnc_flashAction;
[_healer,      "none"] spawn SFSM_fnc_setAction;
[_unconscious, "none"] spawn SFSM_fnc_setAction;


_healer      enableAI "all";
_healer      doFollow (leader group _healer);
_healer      doMove (position leader group _healer);

["revive_done", [_healer, _unconscious, _success]] call CBA_fnc_localEvent;

if(_returnToFipo)then{
    _healer setVariable ["SFSM_myFipo", nil];
    // private _canGetIn = [_healer, _fipo] call SFSM_fnc_canMoveInFipo;
    // if!(_canGetIn)then{[["Cannot get in fipo"],2] call dbgmsg;};
    private _canMove = [_healer, true] call SFSM_fnc_canRun;
    [_healer, _fipo, _canMove] spawn SFSM_fnc_moveInFipo;
};


private _asset = [_healer] call SFSM_fnc_squadAsset;
if(_asset isEqualTo "medic"
&&{! _returnToFipo})then{
    [_healer] call SFSM_fnc_searchAndRevive;
};

_healer removeEventHandler ["Killed", (_healer getVariable "SFSM_myReviveDeathEh")];
_healer setVariable ["SFSM_myReviveTarget", nil];
_healer setVariable ["SFSM_reviving", false, true];

if!(_success)exitWith{false;};

_unconscious enableAI "all";
_unconscious doMove     (position leader group _unconscious);
_unconscious doFollow   (leader group _unconscious);
_unconscious switchMove "AmovPpneMstpSrasWrflDnon";

_asset = [_unconscious] call SFSM_fnc_squadAsset;
if(_asset isEqualTo "medic")then{
    [_unconscious] call SFSM_fnc_searchAndRevive;
};


true;