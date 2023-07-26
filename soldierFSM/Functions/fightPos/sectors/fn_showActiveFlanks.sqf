private _showEmpty = false;
params["_fipo", "_showEmpty"];
private _rightFlank   = _fipo getVariable "rightFlank";
private _leftFlank    = _fipo getVariable "leftFlank";

if(_rightFlank isEqualTo false
&&{_leftFlank  isEqualTo false})exitWith{false};


private _fipoEnemies  = [_fipo] call SFSM_fnc_fipoFlankEnemies;

if(_fipoEnemies isEqualTo [[],[]]
&&{_showEmpty isEqualTo false})exitWith{false;};

private ["_rightFlank3D", "_leftFlank3D"];
private _fipoSectors  = ([_fipo] call SFSM_fnc_fipoFlankSectors);
private _rightFlankOn = _fipoEnemies#0 isNotEqualTo [];
private _leftFlankOn  = _fipoEnemies#1 isNotEqualTo [];
private _3Dsectors    = [];

if(_showEmpty)then{
	_rightFlank3D = [_fipoSectors#0, [0.2,0.6,0,1], "Right flank"]  call SFSM_fnc_sector3D;
	_leftFlank3D  = [_fipoSectors#1, [0.2,0.6,0,1], "Left flank" ]  call SFSM_fnc_sector3D;
};

if(_rightFlankOn)then{
	private _text = [count (_fipoEnemies#0), " Enemies on the right flank"] joinString "";
	_rightFlank3D = [_fipoSectors#0, [0.7,0,0,1], _text]  call SFSM_fnc_sector3D;
	_3Dsectors pushBack _rightFlank3D;

}else{if(_showEmpty && {_rightFlank})then{_3Dsectors pushBack _rightFlank3D;}};


if(_leftFlankOn)then{
	private _text = [count (_fipoEnemies#1), " Enemies on the left flank"] joinString "";
	_leftFlank3D = [_fipoSectors#1, [0.7,0,0,1], _text]  call SFSM_fnc_sector3D;
	_3Dsectors pushBack _leftFlank3D;

}else{if(_showEmpty && {_leftFlank})then{_3Dsectors pushBack _leftFlank3D;}};

{[_x] call SFSM_fnc_add3Dsector;} forEach _3Dsectors;

true;