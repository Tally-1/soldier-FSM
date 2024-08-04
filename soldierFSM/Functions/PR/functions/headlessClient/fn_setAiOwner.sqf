/*
*  fn_setAiOwner.sqf
*  Author: PapaReap
*  Function Name: SFSM_PR_hc_fnc_setAiOwner
*  Keeps spawned units set to spawn owner

*  usage:
*    [units _grp] call SFSM_PR_hc_fnc_setAiOwner;
*    [[_man, _man2]] call SFSM_PR_hc_fnc_setAiOwner;
*/

params ["_unitArray"];

//if HC management is disabled in CBA settings, exit
waitUntil {!isNil PR_disable_HC};
if (PR_disable_HC) exitWith {}; 

if ( !(isNil "PR_HC1") && { (typeName PR_HC1 == "OBJECT") } && { (name PR_AI_SpawnOwner == name PR_HC1) } ) then {
    { hcUnits pushBack _x } forEach _unitArray; publicVariable "hcUnits";
} else {
    if ( !(isNil "PR_HC2") && { (typeName PR_HC2 == "OBJECT") } && { (name PR_AI_SpawnOwner == name PR_HC2) } ) then {
        { hc2Units pushBack _x } forEach _unitArray; publicVariable "hc2Units";
    } else {
        if ( !(isNil "PR_HC3") && { (typeName PR_HC3 == "OBJECT") } && { (name PR_AI_SpawnOwner == name PR_HC3) } ) then {
            { hc3Units pushBack _x } forEach _unitArray; publicVariable "hc3Units";
        } else {
            { serverUnits pushBack _x } forEach _unitArray; publicVariable "serverUnits";
        };
    };
};

if !((["PR_DebugLog", 0] call BIS_fnc_getParamValue) == 0) then { diag_log format ["*PR* setAiOwner = %1", PR_AI_SpawnOwner]; };
