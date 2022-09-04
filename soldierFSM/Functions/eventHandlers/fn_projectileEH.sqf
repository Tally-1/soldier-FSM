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
private _class       = _ammoData get "class ID";
private _handGrenade = "Grenade" in (typeOf _projectile);
private _explosive   = _class > 2.5 && (! (_class in [9.1, 9.2, 9.4]));
private _bullet      = _class > 1 && _class < 3;


if((_handGrenade
|| _explosive))
exitWith{
			[_projectile, _launchPos, _shooter, _ammoType] call SFSM_fnc_explosionEH;
		};

if(_bullet)
exitwith{
			[_projectile, _launchPos, _shooter] call SFSM_fnc_bulletEH;
		};

true;