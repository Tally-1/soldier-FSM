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


private _rightStanceIndex = _fipo getVariable "shootingstanceright";
private _leftStanceIndex  = _fipo getVariable "shootingstanceleft";
private _shootingStance   = _fipo getVariable "shootingStance";
private _coverStance      = _fipo getVariable "coverStance";

private _highAnim  = SFSM_animStances  get _shootingStance;
private _lowAnim   = SFSM_animStances  get _coverStance;
private _rightAnim = SFSM_rightStances get _rightStanceIndex;
private _leftAnim  = SFSM_leftStances  get _leftStanceIndex;
private _unitPos   = _lowAnim#1;

private _dataArr = [
    _highAnim, 
    _lowAnim,
    _rightAnim,
    _leftAnim
] select {!isNil "_x"};

private _c = 0;
private _aslPos = _fipo modelToWorldVisualWorld [0,0,0];

{
    private _animData         = _dataArr#_c;
	private _isCoverIndicator = _animData isEqualTo _lowAnim;
	[
		_x,
		_animData,
		_unitPos,
		_isCoverIndicator

	] call FIPO_fnc_setIndicator;

    _c=_c+1;
} forEach _indicators;


true;