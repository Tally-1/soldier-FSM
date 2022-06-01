while {true}
do {
		{
			private _data 		 = _x getVariable "SFSM_UnitData";
			private _initialized = !isNil "_data";
			private _local 		 = local _x;
			
			if!(_local)		 then{(group _x) setGroupOwner 2};
			if!(_initialized)then{[_x] call Tally_Fnc_SFSM_InitMan};

			[_x] call Tally_Fnc_HandleSuppression
		} 
		forEach allUnits;


		sleep SFSM_TaskCycleTimer;
	};