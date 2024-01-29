params[
	["_wounded",nil, [objNull]], // Unconscious man.
	["_fipo",   nil, [objNull]] //  The FIPO he was in.
];
if(!alive _wounded)exitWith{};

private _healer        = objNull;
private _pos           = getPosATLVisual _wounded;
private _radius        = 7;
private _excludedFipos = [_fipo];
private _excludedMen   = [_wounded];
private _nearFipoMen   = [
	_pos,
	_radius,
	_excludedFipos,
	_excludedMen
] call SFSM_fnc_nearFipoMen;

if(_nearFipoMen isEqualTo [])exitWith{};
_nearFipoMen = [_fipo, _nearFipoMen] call Tcore_fnc_sortByDist;

{
	if(!isNull _healer)exitWith{};

	private _healerPos  = aimPos _x;
	private _woundedPos = aimPos _wounded;
	private _canSee     = ([_healerPos, _woundedPos, _x, _wounded] call SFSM_fnc_lineBroken)isEqualTo false;

	if(_canSee)exitWith{_healer = _x;};
	
} forEach _nearFipoMen;

if(isNull _healer)exitWith{};

private _healerFipo = [_healer] call SFSM_fnc_getFipo;
_healer setVariable ["SFSM_myFipo", _healerFipo];

[_healer]           call SFSM_fnc_getOutFipo;
[_healer, _wounded] spawn SFSM_fnc_buddyRevive;


"Near fipo buddy sent to revive downed man" call dbgmsg;

true;