params ["_launchPos", "_impactPos", "_shooter", "_ammoType"];
private _nearMen = [_shooter, SFSM_explosionCoverRad] call Tcore_fnc_nearSoldiers;

/*
if(SFSM_explosionCrater)
then{[_impactPos, _ammoType] spawn SFSM_fnc_addCrater};
*/


if(isNil "_shooter")exitWith{"shooter undefined" call dbgmsg};
if(_nearMen isEqualTo [])exitWith{"Nobody insde range of explosion" call dbgmsg};

{
	[_x, _launchPos, _impactPos, _shooter] call SFSM_fnc_reactToExplosion

} forEach _nearMen;

// private _text = ["projectile exploded ", (_launchPos distance2D _impactPos), "m from launch position"] joinString "";
// _text call dbgmsg;
true;