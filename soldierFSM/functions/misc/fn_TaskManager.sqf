while {true}
do {
		{
			private _data 		 = _x getVariable "SFSM_UnitData";
			private _initialized = !isNil "_data";
			private _local 		 = local _x;
			
			if!(_local)		 then{(group _x) setGroupOwner 2};
			if!(_initialized)then{[_x] call SFSM_fnc_InitMan};

			[_x] call SFSM_fnc_HandleSuppression
		} 
		forEach allUnits;


		sleep SFSM_TaskCycleTimer;
	};