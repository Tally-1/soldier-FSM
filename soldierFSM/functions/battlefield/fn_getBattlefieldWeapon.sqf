private _type = "launcher";
params ["_man", "_battleField", "_type"];
private _searchRadius  = selectMax [60, SFSM_DodgeDistance];
private _unitPos       = getPos _man;
private _weapons       = missionNamespace getVariable (_battlefield get "weapons");
        _weapons       = _weapons inAreaArray [_unitPos, _searchRadius, _searchRadius];

if(_weapons isEqualTo [])exitWith{};

private _units         = missionNamespace getVariable (_battleField get "units");
private _destinations  = [];
private _weaponClasses = [];
private _usableWeapons = [];



if(_type == "launcher")then{_weaponClasses = [4, 4.01, 4.1, 4.3, 4.4]};

{
	private _weapon = _X;
	if((!isNil "_weapon"))
	then{
			private _weaponName      =  getWeaponCargo _X#0#0;
			private _weaponData      = createHashmap;

			if(!isNil "_weaponName")
			then{
					_weaponData = [_weaponName] call objScan_fnc_weaponData;
			private _weaponClass     = _weaponData get "class ID";
			private _weaponOwner     = _weapon getVariable "SFSM_newOwner";
			private _correctType     = _weaponClass in _weaponClasses;
			private _weaponAvailable = (isNil "_weaponOwner");
			if!(_weaponAvailable)then{_weaponAvailable = (!alive _weaponOwner)};
			

			if(_weaponAvailable
			&&{_correctType
			&&{!isNull _weapon}})
			then{_usableWeapons pushBack _weapon};

		}};

} forEach _weapons;

if(_usableWeapons isEqualTo [])exitWith{};

private _selectedWeapon = [_man, _usableWeapons] call Tcore_fnc_nearestPos;

_selectedWeapon;