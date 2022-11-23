private _ID = 2;

if !(isNil "PR_HC1") then {
    if(typeName PR_HC1 == "STRING")exitWith{};//had an error because this variable was declared as a string.
    if !(isNull PR_HC1) then {
        if !(isServer) then {
            _ID = [PR_HC1] remoteExec ["SFSM_PR_main_fnc_getOwner",[0,2] select isDedicated];
        };
    };
};

{
    if ( !(local _x) && { !(_x getVariable ["SFSM_Excluded",false]) } ) then {
        if !(isServer) then { [_x,_ID] remoteExec ["SFSM_fnc_setGroupOwner",[0,2] select isDedicated]; } else { _x setGroupOwner _ID; };
    };
    [_x] call SFSM_fnc_InitGroup;
    [_x] call SFSM_fnc_handleGroupStance;
} forEach allGroups;

//no worries papa, I deleted it, lets see how it works out.