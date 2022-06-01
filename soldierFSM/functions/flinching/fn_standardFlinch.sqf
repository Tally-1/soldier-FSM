params ["_man"];
_man disableAI "FSM"; 
switch (stance _man) do
	{
		case "STAND" :	{ _man setUnitPos "MIDDLE" };
		case "CROUCH": 	{ _man setUnitPos "DOWN"  };
		case "PRONE" : 	{ [_man] spawn SFSM_fnc_Roll;};
	};

true;