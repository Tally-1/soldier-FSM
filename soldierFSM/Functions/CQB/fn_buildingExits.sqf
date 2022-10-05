params ["_building"];
private _exits = [];
private _maxZ = 0.8;
for "_i" from 0 to 100 
do{
    private _pos = (_building buildingExit _i);
    if(_pos isEqualTo [0,0,0])exitWith{};
    private _valid = (_pos#2<_maxZ &&{_pos#2>(0-_maxZ)});
    if(_valid)then{_exits pushBackUnique _pos;};
    
};

_exits;