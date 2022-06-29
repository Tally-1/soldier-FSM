waitUntil {time > 2};

while {true} do {
sleep SFSM_customEH_Timer;
	{
		private _leader = leader _x;
		private _enemy = ([_leader, _x] call SFSM_fnc_enemySpotted);

		if(!isNull _enemy)
		then{
				private _startBattle = [_leader, _enemy] call SFSM_fnc_canSpotInitBattle;
				if!(_startBattle)exitWith{};
				["Enemy spotted, starting battle"] call SFSM_fnc_debugMessage;
				[_leader, _enemy] call SFSM_fnc_InitBattlefield;
				
			};
	} forEach allGroups;
};
