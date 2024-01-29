params[
	["_man", nil, [objNull]]
];

// Setting all time variables to -300 to allow for 
// proper reactions from the start of the game  
private _dataArr = [
        ["birth",               time ],
        ["Last_Hit",            0-300],
        ["Last_Close_Bullet",   0-300], 
        ["last_bullet_fired",   0-300],
        ["flinchTimer",         0-300],
        ["lastFlinch",          0-300],
        ["dodgeTimer",          0-300],
        ["reactFireTimer",      0-300],
        ["lastBattle",          0-300],
        ["last_time_in_cover",  0-300],
        ["last_AmmoCheck",      0-300],
        ["lastSprintCheck",     0-300],
        ["lastPinDown",         0-300],
        ["huntStart",           0-300],
        ["huntEnded",           0-300],
        ["lastFipoAttempt",     0-300],
        ["peekCooldown",        0-300],
        ["lastPeek",            0-300],
        ["lastOverRun",         0-300],
        ["prevHealTime",        0-300],
        ["lastCqbRpgCheck",     0    ],
        ["roundsPrSecond",      0    ],
        ["action",              "none"],
        ["flashAction",         ""    ],
        ["currentBattle",       "none"],
        ["currentBuilding",     "none"],
        ["targetBuilding",      "none"],
        ["currentDestination",  [0,0,0]],
        ["hashValue",           hashvalue _man],
        ["current suppression", (getSuppression _man)],
        ['pathEnabeled',        (_man checkAIFeature "PATH")],
        ["hunkObjectHash",         []],
        ["flinchTimes",            []],
        ["abortForcedMove",     false],
        ["abortSprint",         false],
        ["checkSprint",          true],
        ["hasForcedMoveProned",  true],
        ["forcedMovement",      false],
        ["inFipo",              false],
        ["isBrainDead",         false],
        ["lastbrainCheck",      0-300],
        ["lastFipoPanicCheck",  0-300],
        ["lastFipoSuppression", 0-300],
        ["fipoPanicCount",          0],
        ["moraleEventsActive",     []],
        ["moraleEvents",           []],
        ["lastMoraleEvent",     0-300],
        ["baseMoraleChecked",   0-300],
        ["baseMorale",              1],
        ["baseMoraleFactors",   createHashmap],
        ["morale",                  1],
        ["playingAnimList",     false],
        ["fleeCoef",                0],
        ["moveRegistry",         []],
        ["failedForcedMoves",      []]
];
 
/*
Examples of how the moves lists should look:

["moveRegistry", [
        time, position,     forcedAnim (If in Fipo or animList is being played)
        [342, [3500,4200,0], false]
]]

["failedForcedMoves", [
        time dist  StartPos       EndPos         TargetPos
        [342, 0,   [3500,4200,0], [3600,4250,0], [3500,4200,0]]
    ]]

*/


private _unitData = createHashMapObject [_dataArr];
_man setVariable["SFSM_UnitData", _unitData, true];