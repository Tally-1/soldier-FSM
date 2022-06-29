//checks if a unit is visible from an array of positions
private _objRadius = 50;
params ["_unit", "_posArr", "_objRadius"];

private _inCover  = true;
private _headPos   = eyePos _unit;

{
	private _pos       = [_x # 0, _x # 1, 1.9];
	private _targetPos = AGLToASL _pos;
	private _targetObj = (nearestObjects [_targetPos, ["Land"], _objRadius]) # 0;
	if(isNil "_targetObj")then{_targetObj = objNull};
		
	private _visibility = ([_unit, "VIEW", _targetObj] checkVisibility [_headPos, _targetPos]);

	_inCover  = (_visibility < 1);
	systemChat str _visibility;

	if!(_inCover)exitWith{};

}forEach _posArr;

_inCover