
private _moveAnimMap = [
	["unscheduled",     true],
	["#type",           "animation-map"],
	["#noCopy",         true],
	["animEndPos",      SFSM_fnc_OOP_animEndPos],
	["getMapByCfgName", SFSM_fnc_OOP_mapByCfgName],
	["playAnim",        SFSM_fnc_OOP_playAnim]
];

SFSM_moveAnims = createHashMapObject [_moveAnimMap];
// SFSM_moveAnimsCFG = createHashMapObject [_moveAnimMap];
// [] call SFSM_fnc_OOP_moveAnimsEntries;
private _moveAnimData = [] call SFSM_fnc_movementAnimData;
private _animBaseMap = [
	["#type", "move-anim"]
];

{
	_x params ["_name", "_dataArr"];
	_dataArr append [
		["#base", _animBaseMap],
		["getEndPos", SFSM_fnc_OOP_getAnimEndPos],
		["name", _name]
	];
	private _map = createHashMapObject [_dataArr];
	SFSM_moveAnims set [_name, _map];
	
} forEach _moveAnimData;

true;



SFSM_moveAnims;