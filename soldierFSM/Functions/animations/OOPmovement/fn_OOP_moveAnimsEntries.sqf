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