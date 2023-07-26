params["_man"];

private _condition = "alive _target &&{side (group _target) isEqualTo side _this}";
private _title = "<t color='#f8aa45'>Calm down</t>";

[_man,
[
    _title,        // title
    {
        params ["_man", "_caller", "_actionId", "_arguments"];
        [_man, _caller] remoteExec ["SFSM_fnc_calmPanicked", (owner _man)];
    },
    nil,         // arguments
    1.5,         // priority
    true,        // showWindow
    true,        // hideOnUse
    "",          // shortcut
    _condition,  // condition
    5,           // radius
    false,       // unconscious
    "",          // selection
    ""           // memoryPoint
]]
remoteExecCall ["addAction", 0];