params ["_coverPos", "_posArr"];
private _isCover        = true;
private _stance   	    = "";

{
	
	private _targetPos = AGLToASL [_x # 0, _x # 1, 2];
	_stance = [_coverPos, _targetPos] call Tcore_fnc_coverPosStance;
	_isCover = !(_stance == "none");
	// systemChat _stance;
	if!(_isCover)exitWith{};

}forEach _posArr;

_stance