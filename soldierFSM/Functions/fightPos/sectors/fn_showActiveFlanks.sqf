params[
	"_fipo", 
	["_showEmpty", false],
	["_showFireSector", false]
];
private _flankActiveR = (_fipo getVariable "rightFlank") > 1;
private _flankActiveL = (_fipo getVariable "leftFlank")  > 1;
private _dynamic      = _fipo getVariable "dynamicFipo";

if(_flankActiveR isEqualTo false
&&{_flankActiveL isEqualTo false
&&{_dynamic      isEqualTo false}})
exitWith{false};


private _fipoEnemies       = [_fipo] call SFSM_fnc_fipoFlankEnemies;
private _fireSectorEnemies = [_fipo] call SFSM_fnc_unitsInFireSector;

if(_fipoEnemies       isEqualTo [[],[]]
&&{_fireSectorEnemies isEqualTo []
&&{_showEmpty         isEqualTo false}})exitWith{false;};

private ["_rightFlank3D", "_fireSector3D", "_leftFlank3D"];
([_fipo] call FIPO_fnc_fipoSectors) params ["_rightSector", "_centerSector", "_leftSector"];


private _3Dsectors        = [];
private _dynamicFipo      = _fipo getVariable "dynamicFipo";
private _rightFlankOn     = _fipoEnemies#0     isNotEqualTo [];
private _leftFlankOn      = _fipoEnemies#1     isNotEqualTo [];

if(_showEmpty)then{
    _rightFlank3D = [_rightSector,  [0.2,0.6,0,1],      "Right flank"]  call SFSM_fnc_sector3D;
    _fireSector3D = [_centerSector, [0.98,0.65,0.21,1], "Fire-Sector" ] call SFSM_fnc_sector3D;
    _leftFlank3D  = [_leftSector,   [0.2,0.6,0,1],      "Left flank" ]  call SFSM_fnc_sector3D;
};

// Show right flank sector
if(_rightFlankOn)then{
    private _text = [count (_fipoEnemies#0), " Enemies on the right flank"] joinString "";
    _rightFlank3D = [_rightSector, [0.7,0,0,1], _text]  call SFSM_fnc_sector3D;
    _3Dsectors pushBack _rightFlank3D;

}else{if(_showEmpty && {_flankActiveR})then{_3Dsectors pushBack _rightFlank3D;}};

// Show Fire-Sector
if(_showEmpty && {_dynamicFipo})then{
    _3Dsectors pushBack _fireSector3D;
}else{
if(_dynamicFipo
&&{_showFireSector})then{
		_fireSector3D = [_centerSector, [1,0.6,0.2,1], "Fire-Sector" ] call SFSM_fnc_sector3D;
		_3Dsectors pushBack _fireSector3D;
}};

// Show left flank sector
if(_leftFlankOn)then{
    private _text = [count (_fipoEnemies#1), " Enemies on the left flank"] joinString "";
    _leftFlank3D = [_leftSector, [0.7,0,0,1], _text]  call SFSM_fnc_sector3D;
    _3Dsectors pushBack _leftFlank3D;

}else{if(_showEmpty && {_flankActiveL})then{_3Dsectors pushBack _leftFlank3D;}};

{[_x] call SFSM_fnc_add3Dsector;} forEach _3Dsectors;

true;