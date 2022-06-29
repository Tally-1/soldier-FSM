//checks the height of an object in order to determine which stance a man should take to get proper cover behind said object.
//returns 0-2. 0 = stand. 1 = crouch. 2 = prone.
params["_object"];
private _objData = [_object] call Tcore_fnc_object3DShape;
private _height  = _objData get "height";
private _stance  = 0;

if(_height < 1.6)then{_stance  = 1};
if(_height < 0.9)then{_stance  = 2};
_stance