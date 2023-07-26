params["_fipo", "_man"];
private _rightFlank   = _fipo getVariable "rightFlank";
private _leftFlank    = _fipo getVariable "leftFlank";

if(isNil "_man")then{_man = [_fipo] call SFSM_fnc_fipoMan;};
if(isNil "_man")exitWith{"no man in fipo" call dbgmsg; [[],[]];};

if(_rightFlank isEqualTo false
&&{_leftFlank  isEqualTo false})exitWith{[[],[]];};

private _distance          = _fipo getVariable "flankdistance";
private _flankSectors      = [_fipo] call SFSM_fnc_fipoFlankSectors;
private _rightSector       = _flankSectors#0;
private _leftSector        = _flankSectors#1;
private _rightFlankEnemies = [];
private _leftFlankEnemies  = [];

{
	private _validEnemy   = ((_man knowsAbout _x isEqualTo 4) && {[_man,   _x] call SFSM_fnc_validEnemy});
	private _onRightFlank = _validEnemy && {_rightFlank && {[_rightSector, _x] call SFSM_fnc_inSector}};
    private _onLeftFlank  = _validEnemy && {_leftFlank  && {[_leftSector,  _x] call SFSM_fnc_inSector}};

	if(_onRightFlank)then{_rightFlankEnemies pushBack _x;};
	if(_onLeftFlank) then{_leftFlankEnemies  pushBack _x;};

	
} forEach (_fipo nearEntities _distance);


[_rightFlankEnemies, _leftFlankEnemies];