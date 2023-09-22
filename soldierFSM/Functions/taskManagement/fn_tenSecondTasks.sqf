// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private 
_script = [] spawn SFSM_fnc_unitTasks;             waitUntil{scriptDone _script};
_script = [] spawn SFSM_fnc_groupTasks;            waitUntil{scriptDone _script};
_script = [] spawn SFSM_fnc_vehicleTasks;          waitUntil{scriptDone _script};

{
	if((getPosATLVisual _x)#2 < (0-1))then{
		private _pos = getPos _x;
		_x setPos [_pos#0,_pos#1,1];
	};

}forEach alldeadMen;
// hint str round time;

// _script = [] spawn SFSM_fnc_deleteDeadData; waitUntil{scriptDone _script};
true;