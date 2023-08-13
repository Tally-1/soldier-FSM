params["_group", "_units"]; 

private _lost = [_group] call SFSM_fnc_battleLost;
if(_lost
&&{_enemies isNotEqualTo []
&&{SFSM_allowSurrender}})
exitWith{"surrender"};


private _man     = _units#0;
private _count   = count _units;
private _morale  = [_units]                        call SFSM_fnc_avgMorale;
private _grpPos  = [(_units apply {getPosASL _x})] call SFSM_fnc_avgPos;
private _enemies = [_man, 100, _grpPos]            call SFSM_fnc_nearEnemies; 
private _allies  = [_man, 100, _grpPos, _units]    call SFSM_fnc_nearAllies; 



private _panic = SFSM_allowPanic
               && {_morale < 1 
               && {_count <= 3 
               && {_enemies isEqualTo []
               }}};
if(_panic)exitWith{"panic"};


private _flee = _morale < 1 
               && {_count >= 3
               && {_enemies isEqualTo []
               }};
if(_flee)exitWith{"flee"};


private _surrender = SFSM_allowSurrender
               && {_morale < 1 
               && {_enemies isNotEqualTo []
               && {_allies isEqualTo []}}};

if(_surrender)exitWith{"surrender"};

"no decision";