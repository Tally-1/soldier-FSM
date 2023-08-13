params["_fipo"]; 
private _height = (getPosATL _fipo)#2;
if(_height < 0.5)exitWith{false;};

private _distSurf = [_fipo] call SFSM_fnc_distanceToFooting;
if(_distSurf < 0.5)exitWith{false;};

true;