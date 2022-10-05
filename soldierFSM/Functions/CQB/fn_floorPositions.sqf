params["_buildingPositions"];
private _floors = [_buildingPositions] call SFSM_fnc_buildingFloors;
if(_floors == 1)exitWith{[_buildingPositions];};

private _avgHeight = [_buildingPositions] call Tcore_fnc_avgHeight;
private _firstFloor = _buildingPositions select {_x#2 < _avgHeight};
private _secondFloor = _buildingPositions select {_x#2 > _avgHeight};


[_firstFloor, _secondFloor];