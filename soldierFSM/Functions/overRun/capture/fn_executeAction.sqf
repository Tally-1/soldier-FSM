params["_man"];

private _condition = "alive _target && {handgunWeapon player isNotEqualTo ''}";
private _title = "<t color='#f8aa45'>Execute</t>";

[_man,
[
    _title,        // title
    {
        params ["_man", "_caller", "_actionId", "_arguments"];
        [_man, _caller] remoteExec ["SFSM_fnc_execute", (owner _man)];
    },
    nil,        // arguments
    1.5,        // priority
    true,        // showWindow
    true,        // hideOnUse
    "",            // shortcut
    _condition, // condition
    5,            // radius
    false,        // unconscious
    "",            // selection
    ""            // memoryPoint
]] 
remoteExecCall ["addAction", 0];