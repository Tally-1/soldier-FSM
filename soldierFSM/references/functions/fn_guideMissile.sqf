// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params[
    "_unit",
    "_missileDistance",
    "_targetDistance", 
    "_projectile", 
    "_targetPos", 
    "_targetZ", 
    "_movement"
];
private _timer = time + 1;
_projectile setMissileTargetPos _targetPos;
"guiding missile" call dbgmsg;
while {
            //while missile has not yet reached / passed its target. 0.02 = 50FPS(ish).
            sleep 0.02; 
            ((_missileDistance < _targetDistance)
            &&{alive _projectile
            &&{time < _timer}});}
            do {
            
            //define necesary variables
            _missileDistance = _unit distance2D _projectile;
            private _wantedDir = round(_projectile getDir _targetPos);
            private _currentDir = round(getDir _projectile);
            private _missileZ = round((getPos _projectile)#2);
            private _reApplyMovement = false;
            // private _currentMovement =  

            // tilt projectile backwards
            if(_missileZ < _targetZ)
            then{
                _projectile setVectorUp [0,-0.5,0.5];
                _reApplyMovement = true;
                };

            //tilt projectile forwards
            if(_missileZ > _targetZ)
            then{
                _projectile setVectorUp  [0,0.33,0.66];
                _reApplyMovement = true;
                };
            
            //set flat tilt(? bad english, sorry---)
            if(_missileZ == _targetZ)
            then{_projectile setVectorUp  [0,0,1];};
            
            //adjust direction
            if((_wantedDir != _currentDir)
            &&{_missileDistance < _targetDistance})
            then{
                sleep 0.02;
                _projectile setDir _wantedDir;
                _reApplyMovement = true;
                };

            //reapply original movement through space, with the altered dir/tilt.
            if(_reApplyMovement)
            then{_projectile setVelocityModelSpace _movement;}
            //if the trajectory is correct, then store the movement, to avoid unatural high speed.
            else{_movement = velocityModelSpace _projectile};
            
        };
_projectile setMissileTargetPos _targetPos;
true;