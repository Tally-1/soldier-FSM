params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
private _pressed = false;

if   (_ctrl 
&&   {_key isEqualTo 34})
then {
        [] call SFSM_fnc_onDbgCurKey;
        _Pressed = true;
};

_Pressed;