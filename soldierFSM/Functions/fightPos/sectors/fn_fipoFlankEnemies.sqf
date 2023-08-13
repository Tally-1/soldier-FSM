params["_fipo", "_man"];
private _flankActiveR = (_fipo getVariable "rightFlank") > 1;
private _flankActiveL = (_fipo getVariable "leftFlank")  > 1;

if(isNil "_man")then{_man = [_fipo] call SFSM_fnc_fipoMan;};
if(isNil "_man")exitWith{"no man in fipo" call dbgmsg; [[],[]];};

if(_flankActiveR isEqualTo false
&&{_flankActiveL isEqualTo false})exitWith{[[],[]];};

private _distR             = _fipo getVariable "rightFlank";
private _distL             = _fipo getVariable "leftFlank";
private _distance          = selectMax [_distR, _distL];

([_fipo] call SFSM_fnc_fipoFlankSectors) 
params ["_rightSector", "_leftSector"];

private _rightFlankEnemies = [];
private _leftFlankEnemies  = [];

{
	private _validEnemy   = ((_man knowsAbout _x isEqualTo 4) && {[_man,   _x] call SFSM_fnc_validEnemy});
	private _onRightFlank = _validEnemy && {_flankActiveR && {[_rightSector, _x] call SFSM_fnc_inSector}};
    private _onLeftFlank  = _validEnemy && {_flankActiveL && {[_leftSector,  _x] call SFSM_fnc_inSector}};

	if(_onRightFlank)then{_rightFlankEnemies pushBack _x;};
	if(_onLeftFlank) then{_leftFlankEnemies  pushBack _x;};

	
} forEach (_fipo nearEntities _distance);


[_rightFlankEnemies, _leftFlankEnemies];