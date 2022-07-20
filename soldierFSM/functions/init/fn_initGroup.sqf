params["_group"];
private _data = _group getVariable "SFSM_groupData";

if(!isNil "_data") exitWith {_data};
if!((side _group) in [east, west, independent])exitWith{};

private _groupData = createHashmap;
_groupData set ["currentBattle",	"none"];
_groupData set ["lastSpotting",	    -300];
_groupData set ["dodgeDisabeled",   false];
_groupData set ["dodgeDisableTime", time];

_group setVariable["SFSM_groupData", _groupData, true];
_group setVariable["SFSM_lastKnownEnemy", objNull, true];

_group setVariable["SFSM_ZeusWaypoints", [], true];