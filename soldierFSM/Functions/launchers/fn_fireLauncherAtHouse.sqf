params[
    ["_man",       nil, [objNull]],
    ["_building",  nil, [objNull]]
];
[_man, _building] call SFSM_fnc_initfireRpgAtHouse;
[_man]            call SFSM_fnc_forceFireLauncher;
[_man]            call SFSM_fnc_endFireRpgAtHouse;

true;