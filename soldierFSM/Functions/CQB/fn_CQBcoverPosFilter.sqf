private _startPos = [(AGLToASL _x), 1] call Tcore_fnc_addZ;
private _endPos = _startPos vectorAdd [0, 0, 10];
private _indoors = (count (lineIntersectsWith [_startPos, _endPos]) > 0);
(_indoors
&&{[_x] call SFSM_fnc_CQBposAvailable})