private _men = missionNamespace getVariable ["SFSM_AimingMen",[]];
_men = _men select {_x distance (positionCameraToWorld [0,0,0]) < 300};

{
	[_x] call SFSM_fnc_aimLine;
	
} forEach _men;

true;