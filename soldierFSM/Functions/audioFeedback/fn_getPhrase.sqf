params["_event"];

if(_event isEqualTo "grenade_evade")exitWith{
    (selectRandom[
        "run",
        "grenade_run",
        "grenade"
    ]);
};

if(_event isEqualTo "grenade_throwback")  exitWith{"i_m_throwing_it_back"};
if(_event isEqualTo "mounting_turret")    exitWith{"mounting_turret"};
if(_event isEqualTo "mg_suppression")     exitWith{"suppressing_the_enemy"};
if(_event isEqualTo "AT_huntStart")       exitWith{"targeting_vehicle"};
if(_event isEqualTo "AT_huntKillTry")     exitWith{"eyes_on_target_firing"};
if(_event isEqualTo "hiding_start")       exitWith{"hide_we_cannot_take_that_vehicle_out"};
if(_event isEqualTo "hiding_end")         exitWith{"it_looks_clear_back_to_action"};
if(_event isEqualTo "dodge_outdoor")      exitWith{"evading_enemy_fire"};
if(_event isEqualTo "dodge_indoor")       exitWith{"moving_indoors"};
if(_event isEqualTo "take_cover_init")    exitWith{"taking_cover"};
if(_event isEqualTo "dragman_start")      exitWith{"relax_buddy_i_am_getting_you_out_of_here"};
if(_event isEqualTo "buddy_revive_init")  exitWith{"come_back_buddy_dont_die"};
if(_event isEqualTo "revive_done")        exitWith{"welcome_back"};
if(_event isEqualTo "CQB_rpg")            exitWith{"engaging_house_with_launcher"};
if(_event isEqualTo "CQB_rpgFire")        exitWith{"get_some"};
if(_event isEqualTo "CQB_explosive")      exitWith{"i_ll_get_some_explosives_in_that_house"};
if(_event isEqualTo "CQB_explosivePlaced")exitWith{"run_the_house_will_explode"};
if(_event isEqualTo "CQB_exploded")       exitWith{"get_some"};
if(_event isEqualTo "CQB_clearing")       exitWith{"clearing_building"};
if(_event isEqualTo "CQB_houseClear")     exitWith{"the_house_is_clear"};
if(_event isEqualTo "vehicle_hijack")     exitWith{"taking_vehicle"};
if(_event isEqualTo "wounded_no_medkit")  exitWith{"wounded_i_need_help"};
if(_event isEqualTo "pinned_down")        exitWith{"pinned_down"};
