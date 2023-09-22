params["_AZ", "_color"];
private _lastActivation = _AZ get "last_activated";
if(time - _lastActivation > 5)exitWith{false;};

private _startPos     = [(_AZ get "position"), 2] call Tcore_fnc_addZ;
private _endPosAlgo   = { [getPosATL _x, 2] call Tcore_fnc_addZ;};
private _endPositions = (_AZ get "fipos") apply _endPosAlgo;

{drawLine3D [_startPos, _x, _color]} forEach _endPositions;

true;