{
	private _data = _x getVariable "SFSM_UnitData";
	private _killTime = _x getVariable "SFSM_killTime";
	private _valid = ((!isNil "_data")
                   &&{(!isNil "_killTime")
				   &&{(time-_killTime)>300}});
    if(_valid)
	then{
          _x setVariable ['SFSM_killTime', nil, true];
		  _x setVariable ['SFSM_UnitData', nil, true];
	};
	
} forEach alldeadMen;