private _action = "placing explosive";
params["_man", "_action"];
private _explosive = [_man] call SFSM_fnc_getChargeFromBackPack;
if(_explosive isEqualTo [])exitWith{};

[_man, "action", _action] call SFSM_fnc_unitData;
_man playMoveNow "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
[_man] call SFSM_fnc_putAnimDoneEH;
// waitUntil{
// 	// [_man, "action"] call SFSM_fnc_unitData == "none";
// 	   private _animDone = _unit getVariable ["SFSM_animDone", false];
// 	   _animDone;
// 	};
sleep 1;
// the name of the inventory item is different from
// the CFG_name used to create the explosive.
// So: _charge = cfg_name, _explosive = inventoryName.

private _charge = _explosive#1;
_explosive = _explosive#0;
private _explosivePos = _man modelToWorld [0,0.3,0];
_charge = createMine [_charge, _explosivePos, [], 0];
_man addOwnedMine _charge;
_man removeItemFromBackpack _explosive;

true;