params["_object", "_targetPosASL"];
isNil{//Forced unscheduled execution.
        private _targetDir    = _object getDir _targetPosASL;
        private _distance     = _object distance2D _targetPosASL;
        private _objectHeight = (getPosASLVisual _object)#2;
        private _targetHeight = _targetPosASL#2;
        private _heightDiff   = _targetHeight - _objectHeight;
        private _low          = _heightDiff < 0;
        private _pitch        = [_heightDiff, _distance] getDir [0,0];
                _pitch        = round((_pitch + 180) % 180);

        if(_low)then{_pitch = 0-(180 - _pitch);};

        _object setDir _targetDir;
        [_object, _pitch, 0] call BIS_fnc_setPitchBank;
};