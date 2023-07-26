params["_marksMan", "_target"];

if(alive _target)then{
    private _weapon = (currentWeapon _marksman);
    [_marksMan, nil, _weapon] spawn SFSM_fnc_multiplyRF;
    
    if!(SFSM_debugger)exitWith{};

    [_marksMan, "Get some!", 0.5]spawn SFSM_fnc_flashAction;
};

//Debug-data 
if!(SFSM_debugger)exitWith{};

sleep 0.01;
if(!alive _target)then{
    [["Marksman ", (name _marksMan), " killed ", (name _target), " at ", round(_marksman distance _target),"m"],2] call dbgmsg;
};

if([_target] call SFSM_fnc_isUncon)then{
[["Marksman ", (name _marksMan), " incapacitated ", (name _target)],2] call dbgmsg;
};

_marksMan setVariable ["SFSM_hitTarget", true, true];
_target setVariable ["SFSM_hitByMarksman", true, true];
sleep 1.5;
_marksMan setVariable ["SFSM_hitTarget", nil, true];
_target setVariable ["SFSM_hitByMarksman", nil, true];

true;