params ["_launchPos", "_impactPos", "_shooter", "_ammoType"];

"handled" call dbgmsg;

private _nearMen = _impactPos nearEntities ["CAManBase", SFSM_explosionCoverRad];//[_shooter, SFSM_explosionCoverRad] call Tcore_fnc_nearSoldiers;
_nearMen = _nearMen select {[_x] call SFSM_fnc_isRealMan;};


if(isNil "_shooter")exitWith{"shooter undefined" call dbgmsg};
if(_nearMen isEqualTo [])exitWith{"Nobody insde range of explosion" call dbgmsg};

{
	[_x, _launchPos, _impactPos, _shooter] call SFSM_fnc_reactToExplosion

} forEach _nearMen;


true;