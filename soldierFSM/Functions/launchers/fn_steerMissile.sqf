// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_projectile","_man", "_targetPos"];
        
        if(_targetPos#2 < 1.6)then{_targetPos = [_targetPos#0,_targetPos#1,1.6]};
        
        private _targetDistance = _man distance2D _targetPos;
        private _missileDistance = _man distance2D _projectile;
        private _movement = velocityModelSpace _projectile;
        private _targetZ = round(_targetPos#2);
        _projectile setMissileTargetPos _targetPos;
        [
            _man,
            _missileDistance,
            _targetDistance,
            _projectile,
            _targetPos,
            _targetZ,
            _movement
        ] spawn SFSM_fnc_guideMissile;
true;