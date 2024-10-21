// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_radius"];

//get near and visible enemies, sorted by distance.
private _enemies = [_man, (([_man, _radius] call SFSM_fnc_nearEnemies) select {[_man, _x] call SFSM_fnc_targetVisible})] call Tcore_fnc_sortByDist;
private _count   = count _enemies;
if(_count > 0)
then{
        private _action    = [_man, "action"] call SFSM_fnc_unitData;
        private _killTimer = time + 10;
        private _actionTxt = "!Targeting Enemy!";

        if(_count > 1)
        then{_actionTxt = [_actionTxt, "(",_foreachIndex+1,"/",_count,")"]joinString""};
        [_man, "action", _actionTxt] call SFSM_fnc_unitData;
        
        {[_man,_x,_killTimer] call SFSM_fnc_attackNearEnemy}forEach _enemies;

        [_man, "action", _action] call SFSM_fnc_unitData;    
};

true;