//original author: KillZone Kid, the function is found at: https://community.bistudio.com/wiki/lineIntersectsWith
// i did edit it slightly to deal ith undefined values.
// Be aware that all lineIntersects commands are heavy and
// should be used with caution.
lineIntersectsSurfaces [
		getPosWorld _this,
		getPosWorld _this vectorAdd [0, 0, 50],
		_this, objNull, true, 1, "GEOM", "NONE"
	] select 0 params ["","","","_house"];
if (isNil "_house")exitWith{false};
if (_house isKindOf "House") exitWith { true };
false