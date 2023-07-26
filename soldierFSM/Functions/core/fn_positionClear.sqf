params["_pos"];
private _groundPos = ATLToASL [_pos#0, _pos#1, 0.1];
private _topPos    = ATLToASL [_pos#0, _pos#1, 5];

private _blocked = [objNull, "VIEW"] checkVisibility [_groundPos, _topPos] < 0.8;
if(_blocked)exitWith{false;};

private _nearObj = nearestTerrainObjects [_pos, ["BUILDING", "HOUSE", "ROCK", "ROCKS", "TREE", "ROAD"], 4]; 
if(count _nearObj > 0)exitWith{false;};

private _nearRoads = _pos nearRoads 10;
if(count _nearRoads > 0)exitWith{false;};

true;