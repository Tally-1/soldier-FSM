params["_man", "_storeData"];
private _leader        = leader group _man;
private _courageFactor = [_man,    "courage"] call SFSM_fnc_skillFactor;
private _commandFactor = [_leader, "commanding"] call SFSM_fnc_skillFactor;
private _allyFactor    = [_man] call SFSM_fnc_alliesFactor;
private _enemyFactor   = [_man] call SFSM_fnc_enemiesFactor;
private _suppression   = [0-(getSuppression _man / 2), 2] call objScan_fnc_decimals;
private _damage        = 0-(damage _man);

private _allFactors    = [
		_courageFactor, 
		_commandFactor, 
		_allyFactor, 
		_enemyFactor, 
		_suppression,
		_damage
];

private _sum = 0;

{
    _sum = _sum + (_x);
    
} forEach _allFactors;

_sum = [_sum - _suppression, 2] call objScan_fnc_decimals;

_allFactors insert [0, [_sum],  false];

if(_storeData)then{
	[_man, _allFactors] call SFSM_fnc_storeMoraleFactors;
};
/*
// Output here is: 
	[
		_sum, 
		_courageFactor, 
		_commandFactor, 
		_allyFactor, 
		_enemyFactor, 
		_suppression,
		_damage
	]
*/

_allFactors;