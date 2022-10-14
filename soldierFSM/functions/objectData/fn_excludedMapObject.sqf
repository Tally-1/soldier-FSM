params["_object"];
private _typeName    = [_object] call Tcore_fnc_simpleObjectType;
private _objectShape = [_object] call Tcore_fnc_object3DShape;
private _height      = _objectShape get "height";
private _excluded = false;

if (_height < 0.4)  exitwith{true};
if (_typeName == "")exitWith{true};

{
	
	if(_x in _typeName) 
	exitWith {_excluded = true};

} forEach SFSM_excludedMapObjs;


_excluded