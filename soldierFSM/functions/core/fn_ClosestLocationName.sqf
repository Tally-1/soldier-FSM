private _radius = 2000;
params ["_position", "_Radius"];
private _locationName = "unknown";
private _locationPos  = [0,0,0];
private _allLocationTypes = [
								["NameCityCapital"],
								["NameCity"],
								["NameVillage"],
								["NameMarine"],
								["NameLocal"]
							];

{
	private _namePos = [_position, _radius, _x] call Tcore_fnc_getLocationNamePos;
	private _name    = _namePos # 0;
	if!(_name == "")
	exitWith{
				_locationName = _name;
				_locationPos  = _namePos # 1;
			};
}forEach _allLocationTypes;


[_locationName, _locationPos]