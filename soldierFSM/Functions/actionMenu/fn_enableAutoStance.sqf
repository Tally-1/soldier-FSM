params["_man"];
if(SFSM_aceLoaded) exitWith{
   [_man] remoteExecCall ["SFSM_fnc_ACE_enableAutoStance", 0, true];
};

private _condition = "
private _disabeled = (group player) getVariable ['SFSM_noAutoStance', false];
if (! _disabeled) exitWith {false};
([_this, _target] call SFSM_fnc_showAutoStAction);
";

private _title = "<t color='#72d15a'>Enable Autostance.</t>";

[_man,
[
    _title,        // title
    {
        params ["_target", "_caller", "_actionId", "_arguments"]; 
        hint "Autostance enabled.";
        group _caller setVariable ["SFSM_noAutoStance", false, true];        
    },
    nil,        // arguments
    1.5,        // priority
    false,        // showWindow
    true,        // hideOnUse
    "",            // shortcut
    _condition, // condition
    1,            // radius
    false,        // unconscious
    "",            // selection
    ""            // memoryPoint
]] 
remoteExecCall ["addAction", 0, true];