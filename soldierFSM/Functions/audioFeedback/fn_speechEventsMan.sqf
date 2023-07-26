

private _eventArr =
[
    "grenade_evade",
    "grenade_throwback",
    "mounting_turret",
    "mg_suppression",
    "AT_huntStart",
    "AT_huntKillTry",
    "hiding_start",
    "hiding_end",
    "dodge_outdoor",
    "dodge_indoor",
    "take_cover_init",
    "dragman_start",
    "buddy_revive_init",
    "revive_done",
    "CQB_rpg",
    "CQB_rpgFire",
    "CQB_explosive",
    "CQB_explosivePlaced",
    "CQB_exploded",
    "CQB_clearing",
    "CQB_houseClear",
    "vehicle_hijack",
    "pinned_down",
    "wounded_no_medkit"
];


{
    private _eventName = _x;

    [_eventName, {
        private _man = _this#0;
        [_man, _eventName] call SFSM_fnc_SquadSay;

    }] call CBA_fnc_addEventHandler;

} forEach _eventArr;