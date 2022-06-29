params ['_battleField'];
sleep SFSM_BattleUpdateSec;

while {!isNil "_battleField"} 
do 	{
		private _ended = [_battleField] call SFSM_fnc_updateBattlefield;
		
		if(isNil "_ended")exitWith{};
		if(_ended)exitWith{};

		sleep SFSM_BattleUpdateSec;
	};

true;