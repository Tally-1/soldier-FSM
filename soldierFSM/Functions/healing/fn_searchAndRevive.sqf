params ["_medic"];
private _woundedMen = (_medic nearEntities ["CAManBase", 99]) 
				select{
				[_medic, _x, false, 99, false] call SFSM_fnc_canBuddyHeal
				&& {_x != _medic
				&& {_x getVariable ["ace_isunconscious", false]
				}}};

if(_woundedMen isEqualTo [])exitWith{};

private _target = ([_woundedMen, [], {_medic distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;

[_medic, _target] spawn  SFSM_fnc_buddyRevive;

true;