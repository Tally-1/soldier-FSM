private _ID = 2;

if !(isNil "PR_HC1") then {
    if !(isNull PR_HC1) then {
        _ID = owner PR_HC1;
    };
};

{
    if ( !(local _x) && { !(_x getVariable ["SFSM_Excluded",false]) } ) then {
        if !(isServer) then { [_x,_ID] remoteExec ["SFSM_fnc_setGroupOwner",[0,2] select isDedicated]; } else { _x setGroupOwner _ID; };
    };
    [_x] call SFSM_fnc_InitGroup;
    [_x] call SFSM_fnc_handleGroupStance;
} forEach allGroups;

{ // why is this here a second time?
    if ( !(local _x) && { !(_x getVariable ["SFSM_Excluded",false]) } ) then {
        if !(isServer) then { [_x,_ID] remoteExec ["SFSM_fnc_setGroupOwner",[0,2] select isDedicated]; } else { _x setGroupOwner _ID; };
    };

} forEach allGroups;