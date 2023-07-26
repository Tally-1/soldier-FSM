//the purpose of this function is to return the indexnumbers for animations
//found in the SFSM_animStances hashMap (see fn_postConfig.sqf).
//the returnValue is an array with 2 numbers.
//used in the SFSM_fnc_fipoPeek function.
//the two numbers are selected based of options defined in the DCO module "fighting Position"

params["_man"];
private _fipo = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")exitWith{};
private _cover = [_fipo getVariable "coverstance",         "SFSM_animStances"];
private _up    = [_fipo getVariable "shootingStance",      "SFSM_animStances"];
private _right = [_fipo getVariable "shootingstanceright", "SFSM_rightStances"];
private _left  = [_fipo getVariable "shootingstanceleft",  "SFSM_leftStances"];


[_cover, _up, _right, _left];