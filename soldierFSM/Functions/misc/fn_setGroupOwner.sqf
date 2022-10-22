/*
*  fn_setGroupOwner.sqf
*  Author: PapaReap
*  Function Name: SFSM_fnc_setGroupOwner

*  Changes the ownership of a group (and all its units) to a given client.
*  The group leader must not be a player.
*  This command only works when called from the server.
*  Returns true if locality was changed.
*  For agents use setOwner command.
*  [[group _unit, true], 2] remoteExec ["SFSM_fnc_setGroupOwner",2];
*/


params ["_group","_clientOwner"];

private _addServerUnits = false;

if (typeName _group == "ARRAY") then {
    private _groupArray = _group;
    _group = _groupArray select 0;

    if (count _groupArray > 1) then {
        if (typeName (_groupArray select 1) == "BOOL") then {
            _addServerUnits = _groupArray select 1;
        };
    };
};

_group setGroupOwner _clientOwner; 
{ _x setVariable ["SFSM_ClientOwner", _clientOwner, true]; } forEach (units _group);

if (_addServerUnits) then {
    if (isNil "serverUnits") then { serverUnits = []; };

    { serverUnits pushBackUnique _x; } forEach (units _group);
    publicVariable "serverUnits";
};
