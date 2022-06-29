private _radius = 1000;
params ["_pos", "_radius"];
private _locationNamePos = [_pos] call Tcore_fnc_closestLocationName;
private _locName         = _locationNamePos # 0;
private _locPos          = _locationNamePos # 1;

if(_locName == "unknown")then{_locPos = _pos};

private _strDir		     = [(_locPos getDir _pos)] call Tcore_fnc_describeDir;
private _distance        = _locPos distance2D _pos;
private _strDist         = [_distance] call Tcore_fnc_describeDistance;
private _areaName        = [_strDist, " ", _strDir, " of ", _locName] joinString "";

if(_distance < 300)then{_areaName = _locName};

_areaName