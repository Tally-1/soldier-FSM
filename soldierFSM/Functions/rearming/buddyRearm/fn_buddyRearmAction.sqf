params ["_man"];

if!(SFSM_buddyRearm)exitWith{};
//SFSM_fnc_canCallBuddyRearm
private _playable = [_man] call SFSM_fnc_playableUnit;
if!(_playable)exitWith{};
private _condition = "(_this) isEqualTo (_target) && {[_this] call SFSM_fnc_canCallBuddyRearm}";

private _title = "<t color='#72d15a'>Call for Ammo!</t>";

[_man,
[
    _title,        // title
    {[] spawn SFSM_fnc_buddyRearm },
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