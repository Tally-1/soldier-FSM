// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Makes an AI unit drop to the ground, or roll if he is already prone.

// Params: [_man:object(the ai soldier)]

// Return value: 0

// Example: [_nySoldado] call SFSM_fnc_BigBulletFlinch;

params ["_man"];

[_man, "action", "flinch"] call SFSM_fnc_unitData;

private _move         = "";
private _standmoves = [ 
    "AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDright",
    "AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft",
    "AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon"
];

private _kneelMoves = [    
    "AmovPknlMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft",
    "AmovPknlMstpSrasWrflDnon_AadjPpneMstpSrasWrflDright"
];

private _proneMoves = [    
    //"AmovPpneMstpSrasWrflDnon_AadjPpneMstpSrasWrflDdown",
    "AmovPpneMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft",
    "AmovPpneMstpSrasWrflDnon_AadjPpneMstpSrasWrflDRight"
];

private _postFnc = { 
    params["_man"];
    [_man, "amovppnemstpsraswrfldnon"] remoteExecCall ["playMoveNow", _man];
    [_man] remoteExecCall ["SFSM_fnc_normalizeStance", _man];
    true;
};

switch (stance _man) do {
    case "STAND":  {_move = selectRandom _standmoves};
    case "CROUCH": {_move = selectRandom _kneelMoves};
    case "PRONE":  {_move = selectRandom _proneMoves};
}; 

["flinch_big", [_man]]   call CBA_fnc_localEvent;

[
    _man, 
    _move,
    [
        [_man],
        false,
        _postFnc
    ]
] call SFSM_fnc_animThenExec;
_man playMove _move; 

0;