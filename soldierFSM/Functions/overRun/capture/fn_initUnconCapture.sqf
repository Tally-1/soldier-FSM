params ["_man", "_captor"];
private _unconscious = [_man] call SFSM_fnc_isUncon;
private _AceCap      = _man getVariable ["ace_captives_issurrendering", false];

if(_unconscious isEqualTo false
&&{_AceCap      isEqualTo false})
exitWith{};

if(_AceCap)then{
	[_man, false] call ACE_captives_fnc_setSurrendered;
};

[_man, false] call ace_medical_fnc_setUnconscious;
[_captor, _man] call ace_medical_treatment_fnc_fullHeal;
[_man] call SFSM_fnc_surrender;

sleep 0.1;
true;