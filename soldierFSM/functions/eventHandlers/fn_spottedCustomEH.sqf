// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

waitUntil {time > 2};

if!(SFSM_enableCustomEH)
exitWith{"custom eventhandler deactivated, using vanilla enemy-detected EH" call dbgmsg};

while {true} do {
sleep SFSM_customEH_Timer;
    {
        private _leader = leader _x;
        private _enemy = ([_leader, _x] call SFSM_fnc_enemySpotted);

        if(!isNull _enemy)
        then{
                private _startBattle = [_leader, _enemy] call SFSM_fnc_canSpotInitBattle;
                if!(_startBattle)exitWith{};
                "Enemy spotted, starting battle" call dbgmsg;
                [_leader, _enemy] call SFSM_fnc_InitBattlefield;
            };
    } forEach allGroups;
};
