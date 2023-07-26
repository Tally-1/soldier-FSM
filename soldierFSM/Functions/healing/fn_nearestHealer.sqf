// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


params["_allHealers", "_woundedMan"];
private _healers = _allHealers select {[_x, _woundedMan] call SFSM_fnc_canBuddyHeal;};
private _nearest = ([_woundedMan, _allHealers] call Tcore_fnc_sortByDist)#0;
_nearest;