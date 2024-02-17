params[
	["_healer",      nil, [objNull]],
	["_unconscious", nil, [objNull]]
];

_healer setVariable ["SFSM_myReviveTarget", _unconscious];
_healer setVariable ["SFSM_myReviveDeathEh",(
_healer addEventHandler ["Killed", {
	"Healer died while trying to revive" call dbgmsg;
	private _reviveTarget = _healer getVariable "SFSM_myReviveTarget";
	[_reviveTarget, "healerDeathTime", time] call SFSM_fnc_unitData;
}])];

true;