params ["_man"];

if!(SFSM_autoStanceAction)exitWith{};

private _playable = [_man] call SFSM_fnc_playableUnit;
if!(_playable)exitWith{};

[_man] call SFSM_fnc_enableAutoStance;
[_man] call SFSM_fnc_disableAutoStance;
true;