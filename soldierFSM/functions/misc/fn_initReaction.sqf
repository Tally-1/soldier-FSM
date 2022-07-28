// The ammo-class is retrieved using the unit-scanner, see references folder for more info.
// Or go to 
// steamPage: https://steamcommunity.com/sharedfiles/filedetails/?id=2811378998
// GitHub:	   https://github.com/Tally-1/SIG-unitScanner

params	[
			"_man", 
			"_ammoCFG", 
			"_shooter"
		];

// private _action = [_man, "action"] call SFSM_fnc_unitData;
// if!(_action == "none") exitWith{};

private _lastBullet 	= [_man, "Last_Close_Bullet"] call SFSM_fnc_unitData;
private _ammoClass		= ([_ammoCFG] call ObjScan_fnc_getAmmoData) get "class ID";
private _canDodge       = [_man] call SFSM_fnc_canDodge;

if(_canDodge)
exitWith{
			[_man, _shooter] spawn SFSM_fnc_Dodge;
			private _group = group _man;
			private _grpDodgeDisabeled = [_group, 'dodgeDisabeled'] call SFSM_fnc_groupData;
			if(_grpDodgeDisabeled)then{'dodge response is blocked by zeus waypoint' call dbgmsg};
		};

//Any projectile from 9.3mm up to a GBU
private _bigProjectile	= (_ammoClass > 2.2 && {_ammoClass < 9.1});
private _canFlinch		= [_man] call SFSM_fnc_canFlinch;

if(_canFlinch)	exitWith{[_man, _bigProjectile, _shooter] call SFSM_fnc_flinch};




true;