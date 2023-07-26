// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_group"];
private _data = _group getVariable "SFSM_groupData";

if(!isNil "_data") exitWith {_data};
if!((side _group) in [east, west, independent])exitWith{};
if(_group getVariable ["SFSM_Excluded",false]) exitWith{};

private _groupData = createHashmap;
_groupData set ["currentBattle",    "none"];
_groupData set ["lastSpotting",        -300  ];
_groupData set ["dodgeDisabeled",   false ];
_groupData set ["dodgeDisableTime", time  ];
_groupData set ["lastPhrases",      []    ];
_groupData set ["fipoGroup",        false ];

_group setVariable["SFSM_groupData", _groupData, true];
_group setVariable["SFSM_lastKnownEnemy", objNull, true];

_group setVariable["SFSM_ZeusWaypoints", [], true];

if((! SFSM_autoStanceEnabled)
&&{[_group] call SFSM_fnc_playableGroup})then{
_group setVariable ["SFSM_noAutoStance", true, true];
};


if!(SFSM_enableCustomEH)
then{[_group] call SFSM_fnc_enemyDetected};

[_group] call SFSM_fnc_leaderChangeEH;
[_group] call SFSM_fnc_groupFleeingEh;