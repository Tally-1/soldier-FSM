params["_fipo"];
private _side    = _fipo getVariable "side";
private _default = "colorBlack";

if(isNil "_side")               exitWith{_default;};
if(_side isEqualTo east)        exitwith{"ColorEAST";};
if(_side isEqualTo independent) exitwith{"ColorGUER";};
if(_side isEqualTo west)        exitwith{"ColorWEST";};

_default;