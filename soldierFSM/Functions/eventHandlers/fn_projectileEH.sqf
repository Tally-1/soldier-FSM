params[
		"_projectile",  
		"_ammoType", 
		"_shooter", //the object that fired the projectile
		"_gunner"   //If the projectile was fired from a vehicle, then _gunner would be the one pulling the trigger
	];

//see: "references/ammoClassDescription.sqf"
//for more info on the ammo classes.

private _launchPos   = getPos _shooter;
private _ammoData    = [_ammoType] call objScan_fnc_getAmmoData;
private _splashR     = _ammoData get "splashRange";
private _class       = _ammoData get "class ID";
private _handGrenade = "Grenade" in (typeOf _projectile);
private _explosive   = _splashR > 6;
private _bullet      = _class > 1 && _class < 3;


if(isNil "_launchPos")then{_launchPos = getPos _projectile};

// [["explosive: ",_explosive]] call dbgmsg;

if((_handGrenade
|| _explosive))
exitWith{
            [_projectile, _launchPos, _shooter, _ammoType] call SFSM_fnc_explosionEH;
            if(_handGrenade)then{[_projectile, _shooter] spawn SFSM_fnc_handleGrenade;};
		};

if(_bullet)
exitwith{
			[_projectile, _launchPos, _shooter] call SFSM_fnc_bulletEH;
		};



true;