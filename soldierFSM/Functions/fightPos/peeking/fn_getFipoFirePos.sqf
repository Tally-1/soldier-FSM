params[
    ["_eyePos", nil,     [[]]],
    ["_fipo",     nil,[objNull]]
];
private _pos    = getPosASLVisual _fipo;
private _up     = (_fipo getVariable "shootingstance")>-1;
private _addedZ = 1.53;
if(_up)exitWith{_pos vectorAdd [0,0,_addedZ]};

private _offSet      = [_fipo] call SFSM_fnc_fiposideStepDistance; 
private _addedZ      = [_fipo] call SFSM_fnc_fiposideStepZ;
private _rightStance = _fipo getVariable "shootingStanceRight";
private _stepRight   = _rightStance isEqualTo 3;

if(_stepRight)exitWith{ 
    private _firePos = (_fipo modelToWorldVisualWorld [_offSet,0,0])vectorAdd [0,0,_addedZ];
    
    _firePos;
};

private _leftStance  = _fipo getVariable "shootingStanceLeft";
private _stepLeft    = _leftStance isEqualTo 3;
if(_stepLeft)exitWith{ 
    private _offSet  = [_fipo] call SFSM_fnc_fiposideStepDistance;
    private _firePos = (_fipo modelToWorldVisualWorld [0-_offSet,0,0])vectorAdd [0,0,_addedZ];
    
    _firePos;
};

_eyePos;