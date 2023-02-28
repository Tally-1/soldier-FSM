params ["_wounded"];
if!(SFSM_dragWounded)exitWith{};

private _house = [_wounded] call SFSM_fnc_currentBuilding;
private _inDoors = !isNil "_house";
if(_inDoors)exitWith{};

private _objTypes    = ["Tree", "Bush", "ROCK", "ROCKS", "RUIN"];
private _nearObjects = nearestTerrainObjects [_wounded, _objTypes, 4];
if!(_nearObjects isEqualTo [])exitWith{};

private _coverPos = [_wounded, nil, SFSM_maxDragDistance] call SFSM_fnc_getCoverPos;
if(isNil "_coverPos")exitWith{};

private _nearMen = _coverPos nearEntities ['CAManBase', 5];

if(count _nearMen > 2)exitWith{};

_coverPos;