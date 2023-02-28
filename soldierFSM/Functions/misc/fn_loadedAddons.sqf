private _addons = [];

{
	private _addonName = _x#1;
	_addons pushBackUnique _addonName;
	
} forEach getLoadedModsInfo;

_addons;