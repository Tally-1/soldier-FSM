private 
_script = [] spawn SFSM_fnc_unitTasks; waitUntil{scriptDone _script};
_script = [] spawn SFSM_fnc_groupTasks; waitUntil{scriptDone _script};
_script = [] spawn SFSM_fnc_vehicleTasks; waitUntil{scriptDone _script};
// _script = [] spawn SFSM_fnc_deleteDeadData; waitUntil{scriptDone _script};
true;