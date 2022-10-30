params["_man", "_vehicle"];
if!(SFSM_hearingHide)exitWith{false;};
if!(isEngineOn _vehicle)exitWith{false;};

private _hearingDistance = SFSM_hearingDistance;
private _distance = (_man distance2D _vehicle);
private _areaName = [_man] call Tcore_fnc_areaName;
private _inUrbanArea = (count (_areaName splitString " ")) == 1;

if(_inUrbanArea)then{_hearingDistance = (SFSM_hearingDistance/2);};

if(_distance > _hearingDistance)exitWith{false;};

true;