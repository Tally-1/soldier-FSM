/*
*  fn_checkSpawner.sqf
*  Author: PapaReap
*  Function Name: SFSM_PR_hc_fnc_checkSpawner
*  Condition Check if unit is allow to run spawn script

*  usage:
*    (call SFSM_PR_hc_fnc_checkSpawner)
*/

if ( !isDedicated && { isServer } ) exitWith { false };

//if HC management is disabled in CBA settings, exit
waitUntil {!isNil PR_disable_HC};
if (PR_disable_HC) exitWith {}; 

_return = if (
    ( !isServer && { hasInterface } )
    || { (isNull PR_AI_SpawnOwner) && { !(isServer) } }
    || { !(isNull PR_AI_SpawnOwner) && { !(PR_AI_SpawnOwner == player) } }
) then { true } else { false };

_return
