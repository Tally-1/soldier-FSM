params ["_man", "_ammoCFG", "_shooter"];
if(isPlayer _man)exitwith{};

//Retrieve values from unit-hashMap
private _lastBullet 	= [_man, "Last_Close_Bullet"] 	call Tally_Fnc_SFSM_unitData;
private _rps			= [_man, "roundsPrSecond"] 		call Tally_Fnc_SFSM_unitData;
private _canFlinch		= [_man] call Tally_Fnc_canFlinch;
private _canDodge		= [_man] call Tally_Fnc_CanDodge;

// The ammo-class is retrieved using the unit-scanner, see references folder for more info.
// Or go to 
// steamPage: https://steamcommunity.com/sharedfiles/filedetails/?id=2811378998
// GitHub:	   https://github.com/Tally-1/SIG-unitScanner

private _ammoClass		= ([_ammoCFG] call Tally_fnc_getAmmoData) get "class ID";
private _bigProjectile	= (_ammoClass > 2.2 && {_ammoClass < 9.1}); //Any projectile from 9.3 up to a GBU

if((time - _lastBullet) < 1 )
then{_rps = _rps + 1}
else{_rps = 1};
	
if(_canFlinch)
then{[_man, _bigProjectile] call Tally_Fnc_flinch};

if(_canDodge)
then{[_man, _shooter] spawn Tally_Fnc_Dodge};

//Store new values into unit-hashMap
[_man, "roundsPrSecond", _rps] 		call Tally_Fnc_SFSM_unitData;
[_man, "Last_Close_Bullet", time] 	call Tally_Fnc_SFSM_unitData;
[_man] 							  	call Tally_fnc_StoreSuppression;