if(SFSM_3Dsectors isEqualTo [])exitWith{};
SFSM_3Dsectors deleteAt (SFSM_3Dsectors findIf {_x#5 < time});

{
	[_x] call SFSM_fnc_drawSector3D;
	
} forEach SFSM_3Dsectors;

true;