private _camPos = (positionCameraToWorld [0,0,0]);
private _men    = _camPos nearEntities  ["man", 200];
{
	private _notPlayer 	= !(isPlayer _x);
	if(_notPlayer)
	then{[_x] call SFSM_fnc_3DdebugText};
} forEach _men;