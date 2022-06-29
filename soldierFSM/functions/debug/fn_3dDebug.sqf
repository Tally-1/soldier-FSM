if(!isnil "3DmarkersSFSM")exitWith{};
3DmarkersSFSM = true;

addMissionEventHandler ["Draw3D", {
if(SFSM_Debugger)
then{
		[] call SFSM_fnc_man3dInfo;
		[] call SFSM_fnc_battlefield3d;
}}];