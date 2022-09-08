params["_group"];
private _noActionLowSuppression = true;

{
	private _action = [_x, "action"] call SFSM_fnc_unitData;
	if((getSuppression _x) < SFSM_ProneTreshHold)
	then{_noActionLowSuppression = false};
	if!(_action == "none")
	then{_noActionLowSuppression = false};

} forEach (units _group);

if!(_noActionLowSuppression)exitWith{};

_group setCombatMode "YELLOW";

//3x spam, because ArmA, some functions do not execute for unknown reasons
{
	_x setUnitPos "auto";
	_x setUnitPos "AUTO";
	_x setUnitPos "AUTO";
}forEach(units _group);

true;