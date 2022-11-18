/*
*  fn_getOwner.sqf
*  Author: PapaReap
*  Function Name: SFSM_PR_main_fnc_getOwner

*  Sever finds owner id

*  Must be a call to server
*  _ownerID = [_unit] remoteExec ["SFSM_PR_main_fnc_getOwner",[0,2] select isDedicated];
*  Returns owner id
*/

params ["_unit"];

_ownerID = owner _unit;

_ownerID
