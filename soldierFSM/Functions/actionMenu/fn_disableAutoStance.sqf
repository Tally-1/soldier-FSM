params["_man"];

if(SFSM_aceLoaded) exitWith{
   [_man] remoteExecCall ["SFSM_fnc_ACE_disableAutoStance", 0, true];
};

private _condition = "
private _disabeled = (group player) getVariable ['SFSM_noAutoStance', false];
if (_disabeled) exitWith {false};
([_this, _target] call SFSM_fnc_showAutoStAction);
";

private _title = "<t color='#dc4141'>Disable Autostance.</t>";

[_man,
[
    _title,        // title
    {
        params ["_target", "_caller", "_actionId", "_arguments"]; 
        hint "Autostance disabled.";
        private _group = group _caller;
        _group setVariable ["SFSM_noAutoStance", true, true];        
    },
    nil,        // arguments
    -1,          // priority
    false,        // showWindow
    true,        // hideOnUse
    "",            // shortcut
    _condition, // condition
    0.5,        // radius
    false,        // unconscious
    "",            // selection
    ""            // memoryPoint
]] 
remoteExecCall ["addAction", 0, true];

/*
condition: String       - (Optional, default "true") expression that must return true for the action to be shown. Special variables passed to the script code are:
_target: Object         - The object to which action is attached or, if the object is a unit inside of vehicle, the vehicle
_this: Object           - Caller person to whom the action is shown (or not shown if condition returns false)
_originalTarget: Object - The original object to which the action is attached, regardless if the object/unit is in a vehicle or not
_actionId: Number       - checked action's ID (same as addAction's return value)
*/

true;