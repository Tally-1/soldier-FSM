params ['_man', '_reactionTime'];
sleep _reactionTime;

[_man, "action", "flinch"] call SFSM_fnc_unitData;

switch (stance _man) do
	{
		case "STAND" :	{ _man setUnitPos "MIDDLE" };
		case "CROUCH": 	{ _man setUnitPos "DOWN"  };
		case "PRONE" : 	{ [_man] spawn SFSM_fnc_Roll;};
	};