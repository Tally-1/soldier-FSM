private _tenSecondTasks = [(SFSM_fnc_unitTasks), (SFSM_fnc_groupTasks)];
private _tenSecondTimer = 0;

while {true}
do {
		if(_tenSecondTimer == 10)
		then{
				private _script = [] spawn SFSM_fnc_tenSecondTasks;
				waitUntil{scriptDone _script};
				_tenSecondTimer = 0;
			};
		
		sleep 1;
		_tenSecondTimer = _tenSecondTimer+1;
	};