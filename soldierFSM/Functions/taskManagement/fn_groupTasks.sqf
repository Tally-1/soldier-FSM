private _ID = 2;

if !(isNil "HC") then {
    if !(isNull HC) then {
        _ID = owner HC;
    };
};

{
    if ( !(local _x) && { !(_x getVariable ["SFSM_Excluded",false]) } ) then {
        if !(isServer) then { [_x,_ID] remoteExec ["SFSM_fnc_setGroupOwner",[0,2] select isDedicated]; } else { _x setGroupOwner _ID; };
    };
    [_x] call SFSM_fnc_InitGroup;
    [_x] call SFSM_fnc_handleGroupStance;
} forEach allGroups;