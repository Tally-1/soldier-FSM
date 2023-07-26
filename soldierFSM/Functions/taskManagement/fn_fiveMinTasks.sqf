private _script = [] spawn SFSM_fnc_garbageCollector; 
waitUntil{scriptDone _script};
true;