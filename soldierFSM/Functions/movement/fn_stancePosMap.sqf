private _posToStanceArr = [ 
    ["UP",     "STAND"],
    ["MIDDLE", "CROUCH"],
    ["DOWN",   "PRONE"]
];

private _stanceToPosArr = [ 
    ["STAND",  "UP"],
    ["CROUCH", "MIDDLE"],
    ["PRONE",  "DOWN"]
];

SFSM_unitPositions = ["UP","MIDDLE","DOWN", "AUTO"];
SFSM_unitStances   = ["STAND","CROUCH","PRONE"];

private _map = createHashMapObject [_posToStanceArr];
SFSM_posToStanceMap = _map;

private _newMap     = createHashMapObject [_stanceToPosArr];
SFSM_stanceToPosMap = _newMap;

SFSM_posToStanceMap;