params ['_battleField'];
sleep SFSM_BattleUpdateSec;

while {!isNil "_battleField"} 
do 	{
		
		

		private _ended = [_battleField] call SFSM_fnc_updateBattlefield;
		if(isNil "_ended")exitWith{};
		if(_ended)exitWith{};

		private _script = [_battleField] spawn SFSM_fnc_updateGrid;
		waitUntil {scriptDone _script};

		// private _script = [_battleField] spawn SFSM_fnc_assignAllBuildings;
		// waitUntil {scriptDone _script};

		private _script = [_battleField] spawn SFSM_fnc_battleFieldCQB;
		waitUntil {scriptDone _script};

		sleep SFSM_BattleUpdateSec;
	};

true;