// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


missionNamespace setVariable ["SFSM_enableCustomEH",  false, true];//using the A3 2.10 eventhandler, this setting is here for legacy reasons
missionNamespace setVariable ["SFSM_forceDodge",      true,  true];
missionNamespace setVariable ["SFSM_Debugger",        false, true];
missionNamespace setVariable ["SFSM_FlinchTreshHold", 1,     true];

if(true)exitWith{};

//Set default settings unless previously defined (usually via CBA settings)
if(isNil "SFSM_allowFlinching")
then{
        SFSM_disableSoldierFSM  = false;   //\\ disable soldier FSM
        SFSM_DebugType          = "always";  // What type of debug is to be used. ["always", "curator", "never"];
        // SFSM_Debugger           = true;   // show debug-info, and 3D markers
        SFSM_allowFlinching     = true;     // Units will flinch on incoming fire.
        SFSM_allowDodging       = true;     // Units will dodge(change position) when incoming fire reaches the treshHold (SFSM_RpsDodgeTrigger).
        SFSM_hideFromVehicles   = true;     // Units will run away / hide from vehicles they cannot hurt.
        SFSM_AtSpecHuntVehicles = true;     // Units with launchers will target enemy vehicles instead of hiding.
        SFSM_ExcludeZcommand    = false;    // stop units that have been given waypoints by a curator from dodging
        SFSM_PlayerGrpDodge     = true;     // Allows units in a group lead by a player to dodge / hide, dodging can be frustrating for players who like to micro-manage their AI
        // SFSM_ProneTreshHold     = 0.8;      // unit will stay prone if suppression is higher than this value
        SFSM_FlinchCoolDown     = 5;        // Minimum Time between each flinch-response
        SFSM_RpsDodgeTrigger    = 4;        // Continous Incoming bullets with no less than 1 second break, to trigger Dodging
        SFSM_DodgeCoolDown      = 10;       // Time between each dodge-response
        SFSM_DodgeDistance      = 70;       // How far the man will run when dodging
        SFSM_DodgeTimer         = 30;       // max time before ending a dodge.
        SFSM_forceDodge         = false;    // Override the Vanilla FSM in order to force the unit to move when dodging
        SFSM_noCoverPanic       = true;     // unit will panic upon initiating a battle if no cover is found
        SFSM_reactFireCoolDown  = 180;      // Time between each returnFire-response        
        SFSM_panicCoef          = 0.5;      // chance that a man will panic upon start of engagement if he cannot see a cover-position
        SFSM_KnowledgeToFight   = 0;       // the amount of knowledge needed to start a battle between 2 units.
        SFSM_sprintSpeed        = 1.3;    // speed coef for dodging / taking cover / hiding. 1 = vanilla. 2 = twice the normal speed
        SFSM_stayCoverPosTime   = 15;    // the amount of time the soldier will stay in his position upon taking cover.
        SFSM_flinchStopDodge    = false; // if this is toggled then the unit will stop running towards cover and instead flinch
        SFSM_emergencyRearm     = true;  // Soldiers pick up launchers from killed squad-mates, or off the ground if a vehicle is nearby
        SFSM_explosionCoverRad  = 200;   // if munition explodes within this distance from the soldier he will run for cover.
        SFSM_breakCoverOnHit    = true;  // if hit while in cover the unit will move away from current position
        SFSM_dodgeIndoors       = false; // If a soldier is inside a house the "dodge" function will activate if the unit is taking heavy fire.
        
        SFSM_CQBdistance        = 100;   // Distance to enemy inside a building needed to activate CQB-mode.
        SFSM_CQBunitCap         = 2;     // The maximum amount of units that can clear the same house at the same time. (Yip wanted 2 as a default, I recomend 4).
        SFSM_hidingTimeOut      = 30;    // The max amount of time a unit will stay in a hiding-pos before returning to normal. (hiding is triggered by the presence of a enemy vehicle)
        SFSM_hearingHide        = true;  // Hide by hearing vehicle: A Vehicle with engine ON is detected within hearing-distance
        SFSM_hearingDistance    = 250;   // Max distance a vehicle will be reacted to by hearing, (if in a urban area, half of this distance is used).

        SFSM_clearHouse         = false; // Allows AI to clear buildings room by room.
        SFSM_houseDemolition    = true;  // Allow units with explosives in their backpack to blow up houses instead of clearing them room by room.
        SFSM_rpgHouse           = true;  // Allow units with RPG's to blow up houses 
        SFSM_globalUD           = false; // Global unit-data

        SFSM_EmergencyHealing   = "whole-body";  // If a soldier is hit, he will inmediately go prone and heal himself, to allow for running.
        SFSM_ACE_Revive         = true;         //  Enables the ai to revive downed men on the battlefield. Beware this is a ''Insta-revive''
        SFSM_throwBackGrenade   = true;        //   Allow units to throw back grenades.
        SFSM_allowHunkerDown    = false;      //    Allow units to hunker down.
        SFSM_mgSuppression      = true;      //     Allow MG's to suppress enemy units.
        SFSM_dragWounded        = true;     //      Allow units to drag wounded units.
        SFSM_minEnemyDistForHealing = 30;  //       No Reviving when known enemies are within this distance.
        SFSM_maxDragDistance    = 40;     //        Max distance a unit will drag a wounded unit.
        SFSM_turretLeaderDist   = 40;    //         Distance to leader for turret gunners to dismount.
        SFSM_maxSprinters       = 10;   //          Max amount of units that can sprint at the same time.
        SFSM_disableSpecialists = "player-squads"; // "all" "player-squads" "none"
        SFSM_specRegroupDist    = 70;             //   Distance to leader for specialists to regroup.
        SFSM_BFFknowledgeType   = "both sides";  //   "one side" "both sides"
        SFSM_autoStanceAction   = true;         // Show action to toggle auto-stance.
        SFSM_autoStanceEnabled  = true;        //  Enable auto-stance for playerGroups.
        SFSM_hijackVehicles     = "action";   //   Allow units to hijack enemy vehicles. ["always", "never", "action"]
        SFSM_overRunDistance    = 50;        // activate overrun when enemy is within this distance 
        SFSM_marksmanFSM        = true;     //  Enable sniper FSM.
        SFSM_maxHuntTime        = 300;     //   How long a hunter will hunt his target.
        SFSM_huntCooldown       = 30;     //    How long until next hunt.

        SFSM_buddyRearm             = true;   // Allow buddy-Rearm
        SFSM_buddyHeal              = true;   // Allow buddy-Heal 
        SFSM_fipoGetInDistance      = 70;     // Distance to squad leader to allow getting into a fipo 
        SFSM_allowFipoTeleport      = true;   // allow man to teleport the last 10m to get into a fipo 
        SFSM_playerSpotTeleportDist = 100;    // how far away a player must be to allow fipo-teleport        
        SFSM_audioFeedbackType      = "voice";// enable audio feedback from ai soldiers ["voice_text", "voice", "english", "none"]
        SFSM_playerSquadFipo        = true;   // enable ai-soldiers in player-squads to get into fipos 
        SFSM_overRun                = true;   // allow overrun actions (surrender / flee / counter)
        SFSM_playerSquadOverRun     = true;   // enable ai-soldiers in player-squads to be overrun
        SFSM_noRubber               = false;  // Prevent sprint-rubberbanding
        SFSM_medicSearchDistance    = 100;    // How far a medic will run in order to revive a downed man (ACE only)

        SFSM_fipoKnockOutTime       = 120;    // How long A FIPO is unusable after a man has been killed / knocked out while in it.
        SFSM_storeMoraleData        = true;   // If MoraleData should be stored in the untData hashmap (mainly used for debugging)
        SFSM_allowPanic             = true;   // If checked then soldiers will Panic under the right conditions.
        SFSM_allowSurrender         = true;   // If checked then soldiers will Surrender under the right conditions.
        FIPO_idleAnimations         = "[
                'Acts_Executioner_Squat',
                'Acts_AidlPercMstpSlowWrflDnon_pissing',
                'Acts_AidlPercMstpSlowWrflDnon_warmup03',
                'Acts_AidlPercMstpSnonWnonDnon_warmup_7_loop',
                'Acts_AidlPercMstpSnonWnonDnon_warmup_6_loop'
        ]";
        SFSM_allowEvasion     = true;   // When no cover is found a soldier will run to avoid incoming fire.
        SFSM_simpleBff        = true;  //  Remove Caching of Terrain objects. Will improve performance, but units taking cover will become slightly dumber.
        SFSM_spawnBffActions  = false;//   Spawns the functions called during a battle in a separate thread, bad for performance but ensures that the loop does not get aborted when an error occurs.
        

        SFSM_shotDistanceDef  = 300; // Default distance a man will hear enemy fire
        SFSM_shotDistanceAss  = 400; // The distance a man will hear enemy Assault rifles firing
        SFSM_shotDistanceMac  = 600; // The distance a man will hear enemy Machine Guns firing
        SFSM_shotDistanceSni  = 800; // The distance a man will hear enemy Sniper Rifles firing
        SFSM_shotDistanceSil  = 100; // The distance a man will hear enemy Silenced weapons firing.
        
        SFSM_bombOnCapture    = 0.2;         // Probability for suicide-bomb when captured.
        SFSM_captureExplosive = "largestEx"; // Choose which explosive you will be used in the case of capture suicide. ("gbu"   "grenade"  "largestEx")
        SFSM_captureAbuseProb = 1;           // Float 0-1 probability that a captive will be beaten.
        SFSM_cptrAbuseProbPlr = 1;           // Float 0-1 probability that a player-captive will be beaten.
        SFSM_captureExecProb  = 1;           // Float 0-1 Probability that a captive Will be executed.
        SFSM_cptrExecProbPlr  = 1;           // Float 0-1 Probability that a player-captive Will be executed.
        SFSM_cptrPlrEscProb   = 0.5;         // The probability for success when a player attempts to break free while captured.
        SFSM_cptrPlrEscTime   = 8;           // How long one escape attempt takes in seconds.
        SFSM_captureTargets   = "all";       // Who can be captured | ["all", "ai", "players", "disabeled"]
        SFSM_captiveAutoDeath = 1;           // How long until a captive dies automatically. -1 = never | [-1,1,2,3,4,5]
        
        SFSM_allowEvasionAttack    = true;   // When rushing an enemy at close range the AI will sometimes do a evasive manouver before firing, such as Zig-Zag or a quick flank.
        SFSM_evasionAttackSpeed    = 1.2;    // Speed coef for evasive attacks. 1 = vanilla. 2 = twice the normal speed
        SFSM_evasionAttackCoolDown = 10;     // How long between each time a soldier can execute an evasive attack.
        SFSM_EA_ZigZag             = true;   // Enable Zig-Zag sidestep evasive attack.
        SFSM_EA_feintPushRight     = true;   // Enable Evade left  -> push right evasive attack.
        SFSM_EA_feintPushLeft      = true;   // Enable Evade right -> push left evasive attack.
        SFSM_EA_flankRight         = true;   // Enable flank right evasive attack.
        SFSM_EA_flankLeft          = true;   // Enable flank left  evasive attack.
}; 

//Make sure settings are available globally.
// 1.44 settings
missionNamespace setVariable ["SFSM_evasionAttackCoolDown", SFSM_evasionAttackCoolDown, true];

// 1.41 settings
missionNamespace setVariable ["SFSM_evasionAttackSpeed", SFSM_evasionAttackSpeed, true];

// 1.37 settings
missionNamespace setVariable ["SFSM_audioFeedbackType", SFSM_audioFeedbackType, true];


// 1.32 settings
missionNamespace setVariable ["SFSM_captureTargets",         SFSM_captureTargets,         true];
missionNamespace setVariable ["SFSM_captiveAutoDeath",       SFSM_captiveAutoDeath,       true];
missionNamespace setVariable ["SFSM_minEnemyDistForHealing", SFSM_minEnemyDistForHealing, true];
missionNamespace setVariable ["SFSM_clearHouse",             SFSM_clearHouse,             true];

// 1.3 settings
missionNamespace setVariable ["SFSM_allowEvasionAttack",  SFSM_allowEvasionAttack, true];

// 1.21 settings
missionNamespace setVariable ["SFSM_shotDistanceDef",  SFSM_shotDistanceDef, true];
missionNamespace setVariable ["SFSM_shotDistanceAss",  SFSM_shotDistanceAss, true];
missionNamespace setVariable ["SFSM_shotDistanceMac",  SFSM_shotDistanceMac, true];
missionNamespace setVariable ["SFSM_shotDistanceSni",  SFSM_shotDistanceSni, true];
missionNamespace setVariable ["SFSM_shotDistanceSil",  SFSM_shotDistanceSil, true];
missionNamespace setVariable ["SFSM_captureAbuseProb", SFSM_captureAbuseProb,true];
missionNamespace setVariable ["SFSM_cptrAbuseProbPlr", SFSM_cptrAbuseProbPlr,true];
missionNamespace setVariable ["SFSM_captureExecProb",  SFSM_captureExecProb, true];
missionNamespace setVariable ["SFSM_cptrExecProbPlr",  SFSM_cptrExecProbPlr, true];
missionNamespace setVariable ["SFSM_cptrPlrEscProb",   SFSM_cptrPlrEscProb,  true];
missionNamespace setVariable ["SFSM_cptrPlrEscTime",   SFSM_cptrPlrEscTime,  true];


// pre 1.21 settings

// missionNamespace setVariable ["SFSM_ProneTreshHold",    SFSM_ProneTreshHold,    true];
missionNamespace setVariable ["SFSM_FlinchCoolDown",    SFSM_FlinchCoolDown,    true];
missionNamespace setVariable ["SFSM_RpsDodgeTrigger",   SFSM_RpsDodgeTrigger,   true];
missionNamespace setVariable ["SFSM_DodgeCoolDown",     SFSM_DodgeCoolDown,     true];
missionNamespace setVariable ["SFSM_DodgeDistance",     SFSM_DodgeDistance,     true];
missionNamespace setVariable ["SFSM_DodgeTimer",        SFSM_DodgeTimer,        true];
missionNamespace setVariable ["SFSM_noCoverPanic",      SFSM_noCoverPanic,      true];
missionNamespace setVariable ["SFSM_reactFireCoolDown", SFSM_reactFireCoolDown, true];
missionNamespace setVariable ["SFSM_ExcludeZcommand",   SFSM_ExcludeZcommand,   true];
missionNamespace setVariable ["SFSM_PlayerGrpDodge",    SFSM_PlayerGrpDodge,    true];
missionNamespace setVariable ["SFSM_hideFromVehicles",  SFSM_hideFromVehicles,  true];
missionNamespace setVariable ["SFSM_AtSpecHuntVehicles",SFSM_AtSpecHuntVehicles,true];
missionNamespace setVariable ["SFSM_disableSoldierFSM", SFSM_disableSoldierFSM, true];

missionNamespace setVariable ["SFSM_allowFlinching",    SFSM_allowFlinching,    true];
missionNamespace setVariable ["SFSM_allowDodging",      SFSM_allowDodging,      true];
missionNamespace setVariable ["SFSM_panicCoef",         SFSM_panicCoef,         true];
missionNamespace setVariable ["SFSM_KnowledgeToFight",  SFSM_KnowledgeToFight,  true];
missionNamespace setVariable ["SFSM_sprintSpeed",       SFSM_sprintSpeed,       true];
missionNamespace setVariable ["SFSM_emergencyRearm",    SFSM_emergencyRearm,    true];
missionNamespace setVariable ["SFSM_explosionCoverRad", SFSM_explosionCoverRad, true];
missionNamespace setVariable ["SFSM_breakCoverOnHit",   SFSM_breakCoverOnHit,   true];
missionNamespace setVariable ["SFSM_EmergencyHealing",  SFSM_EmergencyHealing,  true];
missionNamespace setVariable ["SFSM_dodgeIndoors",      SFSM_dodgeIndoors,      true];
missionNamespace setVariable ["SFSM_CQBdistance",       SFSM_CQBdistance,       true];
missionNamespace setVariable ["SFSM_CQBunitCap",        SFSM_CQBunitCap,        true];
missionNamespace setVariable ["SFSM_hidingTimeOut",     SFSM_hidingTimeOut,     true];
missionNamespace setVariable ["SFSM_hearingHide",       SFSM_hearingHide,       true];
missionNamespace setVariable ["SFSM_hearingDistance",   SFSM_hearingDistance,   true];
missionNamespace setVariable ["SFSM_overrunDistance",   SFSM_overrunDistance,   true];
missionNamespace setVariable ["SFSM_hijackVehicles",    SFSM_hijackVehicles,    true];
missionNamespace setVariable ["SFSM_rpgHouse",          SFSM_rpgHouse,          true];
missionNamespace setVariable ["SFSM_throwBackGrenade",  SFSM_throwBackGrenade,  true];
missionNamespace setVariable ["SFSM_allowHunkerDown",   SFSM_allowHunkerDown,   true];
missionNamespace setVariable ["SFSM_mgSuppression",     SFSM_mgSuppression,     true];
missionNamespace setVariable ["SFSM_dragWounded",       SFSM_dragWounded,       true];
missionNamespace setVariable ["SFSM_maxDragDistance",   SFSM_maxDragDistance,   true];
missionNamespace setVariable ["SFSM_turretLeaderDist",  SFSM_turretLeaderDist,  true];
missionNamespace setVariable ["SFSM_maxSprinters",      SFSM_maxSprinters,      true];
missionNamespace setVariable ["SFSM_disableSpecialists",SFSM_disableSpecialists,true];
missionNamespace setVariable ["SFSM_specRegroupDist",   SFSM_specRegroupDist,   true];
missionNamespace setVariable ["SFSM_BFFknowledgeType",  SFSM_BFFknowledgeType,  true];
missionNamespace setVariable ["SFSM_autoStanceAction",  SFSM_autoStanceAction,  true];
missionNamespace setVariable ["SFSM_autoStanceEnabled", SFSM_autoStanceEnabled, true];

missionNamespace setVariable ["SFSM_marksmanFSM",            SFSM_marksmanFSM,            true];
missionNamespace setVariable ["SFSM_maxHuntTime",            SFSM_maxHuntTime,            true];
missionNamespace setVariable ["SFSM_huntCooldown",           SFSM_huntCooldown,           true];
missionNamespace setVariable ["SFSM_buddyRearm",             SFSM_buddyRearm,             true];
missionNamespace setVariable ["SFSM_buddyHeal",              SFSM_buddyHeal,              true];
missionNamespace setVariable ["SFSM_fipoGetInDistance",      SFSM_fipoGetInDistance,      true];
missionNamespace setVariable ["SFSM_allowFipoTeleport",      SFSM_allowFipoTeleport,      true];
missionNamespace setVariable ["SFSM_playerSpotTeleportDist", SFSM_playerSpotTeleportDist, true];
missionNamespace setVariable ["SFSM_playerSquadFipo",        SFSM_playerSquadFipo,        true];
missionNamespace setVariable ["SFSM_overRun",                SFSM_overRun,                true];
missionNamespace setVariable ["SFSM_DebugType",              SFSM_DebugType,              true];
missionNamespace setVariable ["SFSM_noRubber",               SFSM_noRubber,               true];
missionNamespace setVariable ["SFSM_medicSearchDistance",    SFSM_medicSearchDistance,    true];
missionNamespace setVariable ["SFSM_globalUD",               SFSM_globalUD,               true];
missionNamespace setVariable ["SFSM_fipoKnockOutTime",       SFSM_fipoKnockOutTime,       true];
missionNamespace setVariable ["SFSM_storeMoraleData",        SFSM_storeMoraleData,        true];
missionNamespace setVariable ["FIPO_idleAnimations",         FIPO_idleAnimations,         true];
missionNamespace setVariable ["SFSM_allowEvasion",           SFSM_allowEvasion,           true];
missionNamespace setVariable ["SFSM_ACE_Revive",             SFSM_ACE_Revive,             true];


true;