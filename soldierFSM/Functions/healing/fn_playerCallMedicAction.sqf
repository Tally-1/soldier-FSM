params ["_man"];

if!(SFSM_buddyHeal)exitWith{};

private _playable = [_man] call SFSM_fnc_playableUnit;
if!(_playable)exitWith{};
private _condition = "(_this) isEqualTo (_target) && {[_this] call SFSM_fnc_canCallMedic}";

private _title = "<t size='1.1' color='#dc6946'>Call for Medic!</t>";

private _actionId =
[_man,
[
    _title,     // title
    {[] spawn SFSM_fnc_callPlayerMedic },
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

true;