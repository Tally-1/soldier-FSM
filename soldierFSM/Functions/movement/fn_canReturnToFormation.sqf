params[ 
	["_man", nil, [objNull]]
];
private _canReturn = false;
isNil{
private _unitData         = _man getVariable "SFSM_unitData";
private _group            = group _man;
private _leader           = leader _group;
private _distance         = _man distance2D _leader;
private _enemyDistance    = [_man, 100] call SFSM_fnc_distanceToKnownEnemy;
private _timeSinceShotIn  = time - (_unitData get "Last_Close_Bullet");
private _timeSinceShotOut = time - (_unitData get "last_bullet_fired");
private _timeSinceCombat  = selectMin [_timeSinceShotIn, _timeSinceShotOut];

if (_distance      < 50)                           exitWith{};
if (_enemyDistance < 100)                          exitWith{};
if (_timeSinceCombat < 30)                         exitWith{};
if!(alive _leader)                                 exitWith{};
if!([_man, true] call SFSM_fnc_availableAiSoldier) exitWith{};

_canReturn = true;
};

_canReturn;