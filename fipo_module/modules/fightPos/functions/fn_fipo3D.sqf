if(!isnil "fipoSectors3D")exitWith{};
fipoSectors3D = true;


addMissionEventHandler ["Draw3D", {
private _i = 0;
{
    if(_i < 5
	&&{[_x] call FIPO_fnc_showFlanks})then{
	   [_x] call FIPO_fnc_drawFipoSectors;
		_i=_i+1;
	};

} forEach (get3DENSelected "logic");

}];