params ['_battleField'];

while {!isNil "_battleField"} 
do 	{
		
		

		private _ended = [_battleField] call SFSM_fnc_updateBattlefield;
		if(isNil "_ended")exitWith{};
		if(_ended)exitWith{};

		// _battlefield set ["currentAction",	"Medical actions"];
		// private _script = [_battleField] spawn SFSM_fnc_battleFieldMedical;
		// waitUntil {
		// 	private _finito = scriptDone _script;
		// 	if(isNil "_finito")exitWith{true;};
		// 	_finito; 
		// };
		

		private _script = [_battleField] spawn SFSM_fnc_updateGrid;
		waitUntil {
			private _finito = scriptDone _script;
			if(isNil "_finito")exitWith{true;};
			_finito; 
		};

		private _script = [_battleField] spawn SFSM_fnc_battleFieldCQB;
		waitUntil {
			private _finito = scriptDone _script;
			if(isNil "_finito")exitWith{true;};
			_finito; 
		};

		_battlefield set ["currentAction",	"Assigning vehicles"];
		private _script = [_battleField] spawn SFSM_fnc_hijackAllVehicles;
		waitUntil {
			private _finito = scriptDone _script;
			if(isNil "_finito")exitWith{true;};
			_finito; 
		};

		
		_battlefield set ["currentAction",	"Reinforcing vehicles"];
		private _script = [_battleField] spawn SFSM_fnc_reinforceVehicles;
		waitUntil {
			private _finito = scriptDone _script;
			if(isNil "_finito")exitWith{true;};
			_finito; 
		};

		// _battlefield set ["currentAction",	"Medical actions"];
		// private _script = [_battleField] spawn SFSM_fnc_battleFieldMedical;
		// waitUntil {
		// 	private _finito = scriptDone _script;
		// 	if(isNil "_finito")exitWith{true;};
		// 	_finito; 
		// };

		_battlefield set ["currentAction",	"none"];

		sleep SFSM_BattleUpdateSec;
	};

true;