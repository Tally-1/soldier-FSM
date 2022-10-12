/*
Supressed params documentation.

* unit: Object - Unit to which the event is assigned
* distance: Number - Distance of the projectile pass-by
* shooter: Object - Who (or what) fired - vehicle or drone
* instigator: Object - Who pressed the trigger. Instigator is different from the shooter when player is operator of UAV for example
* ammoObject: Object - The ammunition itself
* ammoClassName: String - The ammunition's classname
* ammoConfig: Config - The ammunition's CfgAmmo config path

*/

Params ["_man"];
if!([_man] call SFSM_fnc_isRealMan)exitWith{};

private _unitData = (_man getVariable "SFSM_UnitData");

//exit on all unwanted object-types (_man);
if(isNil "_unitData")exitWith{[_man] call SFSM_fnc_InitMan};
if([(group _man)] call Tcore_fnc_nilNull)exitWith{};
if([_man] call Tcore_fnc_nilNull)exitWith{};
if([_man] call Tcore_fnc_isPlayer)exitWith{};

//overWrite previous EH.
if("SuppressedEH" in _unitData) then{_man removeEventHandler ["Suppressed", (_unitData get "SuppressedEH")]};
if("explosionEH" in _unitData) then{_man removeEventHandler ["Explosion", (_unitData get "SuppressedEH")]};

private _SuppressedEH =
_man addEventHandler ["Suppressed", {
	params ["_unit", "_distance", "_shooter", "_instigator", "_ammoObject", "_ammoClassName", "_ammoConfig"];
	if (!alive _unit)exitWith{};
	if((!(SFSM_TestMode)) 
	&&{(side _man == side _shooter)})exitwith{};

	[_unit, _ammoClassName, _shooter] call SFSM_fnc_onSuppression;
	
}];

private _explosionEH = 
_man addEventHandler ["Explosion", {
	params ["_vehicle", "_damage", "_source"];
	
	if([_man] call SFSM_fnc_canFlinch)
	then{
			[_vehicle, true] call SFSM_fnc_flinch;
	};

}];

[_man, "SuppressedEH", _SuppressedEH] call SFSM_fnc_unitData;
[_man, "explosionEH", _explosionEH] call SFSM_fnc_unitData;




if(SFSM_TestMode)
then{
		/*Only for function testing */
		_man removeAllEventHandlers "FiredNear";
		_man addEventHandler ["FiredNear", {
			params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
			if(SFSM_TestMode)then{[_unit, _ammo, _firer] call SFSM_fnc_onSuppression};

		}];
};

true;