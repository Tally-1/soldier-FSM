params ["_fipo"];
private _indicators = _fipo getVariable ["indicators", []];
_indicators = _indicators select {!isNull _x};
if(_indicators isEqualTo [])exitWith{systemchat "no indicators";};

if(isNil "SFSM_animStances")then{
    [] call FIPO_fnc_fipoStances;
    systemChat "stances loaded";
};

private _currentType = typeOf (_indicators#0);
private _type = [_fipo] call FIPO_fnc_indicatorType;

if(_type isNotEqualTo _currentType)exitWith{
    [_fipo] call FIPO_fnc_deleteIndicators;
    [_fipo] call FIPO_fnc_fipoChanged;
};


private _highAnim  = SFSM_animStances  get (_fipo getVariable "shootingStance");
private _lowAnim   = SFSM_animStances  get (_fipo getVariable "coverStance");
private _rightAnim = SFSM_rightStances get (_fipo getVariable "shootingstanceright");
private _leftAnim  = SFSM_leftStances  get (_fipo getVariable "shootingstanceleft");
private _dataArr = [
    _highAnim, 
    _lowAnim,
    _rightAnim,
    _leftAnim
] select {!isNil "_x"};

private _c = 0;
private _aslPos = _fipo modelToWorldVisualWorld [0,0,0];

{
    private _animData  = _dataArr#_c;
    private _animation = _animData#0;
    private _leftLean  = "left"  in _animation;
    private _rightLean = "right" in _animation;
    private _leaning   = _leftLean || _rightLean;

    if(_leaning)then{
        private _offSet = _animData#3;
        _aslPos = _fipo modelToWorldVisualWorld [_offSet,0,0]; 

        if(_leftLean)then{
            _aslPos = _fipo modelToWorldVisualWorld [0-_offSet,0,0];
        };

               
    };
    
    _x switchMove _animation;
    _x setPosASL _aslPos;
    _x setDir (getDir _fipo);

    //Give a different color to the cover-stance-indicator
    if(_animData isEqualTo _lowAnim)then{
        [_x, "...",0]     call FIPO_fnc_setTextTexture;
        [_x, "...",1]     call FIPO_fnc_setTextTexture;
        [_x, "...",2]     call FIPO_fnc_setTextTexture;
        [_x, "...",3]     call FIPO_fnc_setTextTexture;
        [_x, "...",4]     call FIPO_fnc_setTextTexture;
        [_x, "...",5]     call FIPO_fnc_setTextTexture;
        [_x, "X","clan"]  call FIPO_fnc_setTextTexture;
    };
    

    _c=_c+1;

} forEach _indicators;


true;