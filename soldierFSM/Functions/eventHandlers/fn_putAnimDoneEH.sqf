params["_man"];
_man addEventHandler ["AnimDone", {
	params ["_unit", "_anim"];
	if("AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon" == _anim)
	then{
		// [_unit, "action", "none"] call SFSM_fnc_unitData;
		_unit setVariable ["SFSM_animDone", true];
		_unit removeEventHandler [_thisEvent, _thisEventHandler];
	};
}];