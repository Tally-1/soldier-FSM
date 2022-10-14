params ["_group"];

_group addEventHandler ["EnemyDetected", {
	params ["_group", "_newTarget"];
	if(side _group == sideLogic)exitWith{};
	private _leader 	= leader _group;
	private _knowledge  = _leader knowsAbout _newTarget;
	private _knowsAboutEnemy = _knowledge > SFSM_KnowledgeToFight;
	private _canInitBattle = [_leader, _newTarget] call SFSM_fnc_canSpotInitBattle;
	private _debugText = "not enough knowledge to init battle";

	if!(_knowsAboutEnemy)exitWith{_debugText call dbgmsg};
	if!([_leader] call SFSM_fnc_isRealMan)exitWith{};
	if!([_newTarget] call SFSM_fnc_isRealMan)exitWith{};
	if!(_canInitBattle)exitWith{};
	
	[_leader, _newTarget] call SFSM_fnc_InitBattlefield;
	"Enemy spotted, starting battle" call dbgmsg;

	true;
}];

true;