/*
	This function is called by battlefieldPostInit. 
	It returns a boolean value, if returnValue is true the unit will do some action defined below

	Hence in order to have the unit execute a special action then make sure you spawn the new action 
	and return true. See lines 19-23 for an example.
*/
params ["_man", "_battlefield"];
private _special = [_man] call SFSM_fnc_squadAsset;
private _player  = [_man] call Tcore_fnc_isPlayer;

if(_player)              exitWith{false};
if(_special == "regular")exitWith{false};
if(_special == "medic")  exitWith{false};

if(_special == "machineGunner")
exitWith{
			[_man] spawn SFSM_fnc_machineGunInitFight;
			true;
};

if(_special == "AT-specialist")
exitWith{
			[_man] spawn SFSM_fnc_AtSpecialistInitFight;
			true;
};

false