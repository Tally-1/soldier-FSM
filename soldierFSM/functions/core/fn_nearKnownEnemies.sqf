private _distance = 500;
private _returnData = 'positions'; 
params ["_unit", "_distance", "_returnData"];
private _targetsData = _unit nearTargets _distance;
private _side = side _unit;
private _enemyPositions = [];
private _enemies        = [];


{
	private _thisSide = side (_x#4);
	private _enemy    = !([_Side, _thisSide] call BIS_fnc_sideIsFriendly);
	private _unitObj  = _x#4;
	private _position = _x#0;
	
	if(alive _unitObj
	&&{!(_thisSide == civilian)
	&&{_enemy
	&&{_unitObj isKindOf "land"}}})
	then{
			_enemyPositions pushback _position;
			_enemies        pushback _unitObj;
		};

	
} forEach _targetsData;


if(_returnData == 'positions') exitwith {_enemyPositions};
if(_returnData == 'enemies')   exitwith {_enemies};

private _enemiesAndPos  = [_enemyPositions, _enemies];

_enemiesAndPos;




/*
ReturnValue of nearTargets
[
	[
		[23226.8,19363.5,1.18548], 	#0=pos
		"O_Soldier_AR_F",			#1=type
		EAST,						#2=percieved side
		580083,						#3=cost(???)
		O Alpha 1-4:2,				#4=object
		0.0756257                   #5=accuracy of percieved position
	]
	
]
*/