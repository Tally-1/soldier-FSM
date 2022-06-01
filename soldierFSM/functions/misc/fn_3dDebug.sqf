if(!isnil "3DmarkersSFSM")exitWith{};
3DmarkersSFSM = true;

addMissionEventHandler ["Draw3D", {
if(SFSM_Debugger)
then{
		{
			private _close 		=  ((positionCameraToWorld [0,0,0]) distance _x) < 200;
			private _notPlayer 	= !(isPlayer _x);

			if(_close
			&&{_notPlayer})
			then{[_x] call SFSM_fnc_3DdebugText};
			
		} forEach allUnits;
}}];