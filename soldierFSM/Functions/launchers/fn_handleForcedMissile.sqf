params[
    ["_man",     nil, [objNull]],
    ["_missile", nil, [objNull]]
];
SFSM_bullets pushBack _missile;
private _target         = _man getVariable "SFSM_missileTargetBuilding";
private _targetPos      = _man getVariable "SFSM_missileTargetPos";
private _targetAltitude = _targetPos#2;
private _velocityMS     = velocityModelSpace _missile;
private _maxSpeed       = 400;
private _startSpeed     = round((_velocityMS#1)*0.9);

[_missile, _targetPos] call SFSM_fnc_setDirAndPitchToPos;
_missile setVelocityModelSpace _velocityMS;

if([_missile, _target, 20] call SFSM_fnc_missileAimed)
exitWith{_missile setVelocityModelSpace [0, _maxSpeed, 0];};

while {sleep 0.1; alive _missile} do {
        if(!alive _missile)
        exitWith{};
        if([_missile, _target] call SFSM_fnc_missileAimed)
        exitWith{_missile setVelocityModelSpace [0, _maxSpeed, 0]};
        
        private _altitude  = (getPosASL _missile)#2;
        private _tooLow    = _altitude < _targetAltitude || _altitude < 1;
        private _tooHigh   = _altitude > 2 && {_tooLow isEqualTo false};
        private _velocity  = velocityModelSpace _missile;
        private _distance  = _missile distance2D _targetPos;
        private _dir       = getDirVisual _missile;
        private _targetDir = _missile getDir _targetPos;
        private _deviated  = ([_dir, _targetDir, 20] call SFSM_fnc_inDirRange);

        

        if(_tooLow)then{
            _velocity params ["_drift", "_speed", "_lift"];
            
            _missile setVelocityModelSpace [_drift, _speed, 10];
            _velocity = velocityModelSpace _missile;

            [_missile, _targetPos] call SFSM_fnc_setDirAndPitchToPos;
            _missile setVelocityModelSpace _velocity;
        };

        _velocity params ["_drift", "_speed", "_lift"];
        if(_tooHigh
        &&{_lift > 0})then{
            _missile setVelocityModelSpace [_drift, _speed, 0];
            _velocity = velocityModelSpace _missile;
        };

        if((_velocity#1) < _startSpeed)then{ 
            _velocity params ["_drift", "_speed", "_lift"];

            _missile setVelocityModelSpace [_drift, _maxSpeed, _lift];
            _velocity = velocityModelSpace _missile;
        };

        if(_deviated)then{ 
            [_missile, _targetPos] call SFSM_fnc_setDirAndPitchToPos;
            _missile setVelocityModelSpace _velocity;
        };

        true;
};

true;