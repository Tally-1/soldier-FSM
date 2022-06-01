params["_man"];
private _unitData 	= 	(_man getVariable "SFSM_UnitData");
		_unitData set 	["current suppression", (getSuppression _man)];
		_man setVariable["SFSM_UnitData", _unitData, true];