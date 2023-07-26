params ["_battlefield"];

if(isNil "_battlefield") exitWith{};

Private _groups = missionNamespace getVariable (_battlefield get "groups");
if(isNil "_groups") exitWith{};

private _marksMen = [_groups] call SFSM_fnc_getMarksMen select {[_x] call SFSM_fnc_canHunt;};
if(_marksMen isEqualTo []) exitWith{
    "No available marksmen" call dbgmsg;
};

private _targets = [_battlefield] call SFSM_fnc_getHVTs;
private _sides   = [];
_targets append _marksMen;

{_sides pushBackUnique (side _x)} forEach _targets;

if(count _sides < 2)      exitWith{"no valid targets found for marksmen" call dbgmsg;};
if(_targets isEqualTo []) exitWith{"no valid targets found for marksmen" call dbgmsg;};

private _hunters = [];
{   
    if(isNil "_battlefield") exitWith{};
    if([_x] call SFSM_fnc_availableAiSoldier)then{
    
    [_x, "action", "Searching for targets"] call SFSM_fnc_unitData;
    private _target = [_x, _targets] call SFSM_fnc_selectMarksmanTarget;

    if(!isNull _target)then{
        [_x, _target] spawn SFSM_fnc_huntTarget;
        _hunters pushBackUnique _x;
    }
    else{
        [_x, "action", "none"] call SFSM_fnc_unitData;
        [_x, "Failed to aquire target"]spawn SFSM_fnc_flashAction;
    };

    sleep 0.05;

}} forEach _marksMen;

if(isNil "_battlefield") exitWith{};

if(_hunters isEqualTo [])exitWith{
    "no valid targets found for marksmen" call dbgmsg;
};

"marksmen assigned to targets" call dbgmsg;

true;