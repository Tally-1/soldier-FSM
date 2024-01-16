params  ["_animCfgName"];
private ["_animMap"];

_animCfgName = toLowerANSI _animCfgName;

{
	private _cfgName = "";

	if(typeName _y isEqualTo "HASHMAP")
	then{_cfgName = toLowerANSI (_y get "animName");};

	if(_cfgName isEqualTo _animCfgName)
	exitWith{_animMap = _y;};
	
} forEach _self;

if(!isNil "_animMap")exitWith{_animMap};

nil;