/*
	This function is called by battlefieldPostInit. 
	It returns a boolean value, if returnValue is true the unit will do some action defined below

	Hence in order to have the unit execute a special action then make sure you spawn the new action 
	and return true. See lines 19-23 for an example.
*/
params ["_man", "_battlefield"];
private _special = [_man] call SFSM_fnc_squadAsset;
private _player  = [_man] call Tcore_fnc_isPlayer;
private _pathEnabeled = [_man, "pathEnabeled"] call SFSM_fnc_unitData;

if!(_pathEnabeled)       exitWith{false};
if(_player)              exitWith{false};
if(_special == "regular")exitWith{false};
if(_special == "medic")  exitWith{false};

private _grpCanDodge = ([_group] call SFSM_fnc_groupCanDodge);
private _machineGunner = _special == "machineGunner";
private _at_Specialist = _special == "AT-specialist";

if((! _grpCanDodge)
&&{_machineGunner or _at_Specialist})
exitWith{'specialist in playerGroup / zeus' call dbgmsg; false};



if(_machineGunner
&&{SFSM_mgSuppression})
exitWith{
			[_man] spawn SFSM_fnc_machineGunInitFight;
			true;
};

if(_at_Specialist)
exitWith{
			[_man] spawn SFSM_fnc_AtSpecialistInitFight;
			true;
};


false;