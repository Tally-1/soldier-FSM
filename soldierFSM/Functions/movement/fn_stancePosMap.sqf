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

private _stanceToAnimArr = [ 
    ["STAND",  "amovpercmstpsraswrfldnon"],
    ["CROUCH", "amovpknlmstpsraswrfldnon"],
    ["PRONE",  "amovppnemstpsraswrfldnon"]
];

SFSM_unitPositions = ["UP","MIDDLE","DOWN", "AUTO"];
SFSM_unitStances   = ["STAND","CROUCH","PRONE"];

private _posMap     = createHashMapObject [_posToStanceArr];
SFSM_posToStanceMap = _posMap;

private _stanceMap  = createHashMapObject [_stanceToPosArr];
SFSM_stanceToPosMap = _stanceMap;

private _stanceAnimMap = createHashMapObject [_stanceToAnimArr];
SFSM_stanceToAnimMap   = _stanceAnimMap;

SFSM_posToStanceMap;