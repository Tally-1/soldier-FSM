//Searches for Gl-muzzle on a infantry rifle, returns CFG_name of muzzle and mag capacity
params ["_weapon"];
private _weaponData	   = [_weapon] call ObjScan_fnc_weaponData;
private _weaponMuzzles = _weaponData get "muzzles";
private _gLauncher     = "";
private _hasGL         = false;
private _glMagSize     = 0;


if(count _weaponMuzzles > 0)
then{
		
		{
			
			if(typeName _y == "HASHMAP")
			then{
					_gLauncher	= _x;
					_hasGL 		= 3 in (_y get "ammoClasses");
					_glMagSize  = _y get "max-Ammo-Cap";
				};

			if(_hasGL)exitWith{};
			
		} forEach _weaponMuzzles;
		
	};

[_gLauncher, _glMagSize]