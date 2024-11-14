params[
	["_man1", nil, [objNull,west,grpNull,createHashmap]],
	["_man2", nil, [objNull,west,grpNull,createHashmap]]
];
private ["_sideA", "_sideB"] ;

if(typeName _man1 isEqualTo "SIDE")then{_sideA = _man1};
if(typeName _man2 isEqualTo "SIDE")then{_sideB = _man2};

if(typeName _man1 isEqualTo "GROUP")then{_sideA = (side _man1)};
if(typeName _man2 isEqualTo "GROUP")then{_sideB = (side _man2)};

if(typeName _man1 isEqualTo "OBJECT")then{_sideA = (side group _man1)};
if(typeName _man2 isEqualTo "OBJECT")then{_sideB = (side group _man2)};

if(typeName _man1 isEqualTo "HASHMAP")then{_sideA = _man1 get "side"};
if(typeName _man2 isEqualTo "HASHMAP")then{_sideB = _man2 get "side"};

private _isHostile = !([_sideA, _sideB] call BIS_fnc_sideIsFriendly);

_isHostile;