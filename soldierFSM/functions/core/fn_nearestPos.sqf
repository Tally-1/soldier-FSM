Params ["_Pos", "_ObjArr"];//accepts both positions and objects
Private _minDistance    = 100000;
Private _objDistance    = 100000;
Private _Nearest        = 0;

if(Isnil "_ObjArr"
&&{!Isnil "_Pos"})exitWith{_Pos};

if(Isnil "_Pos"
&&{!Isnil "_ObjArr"})exitWith{_ObjArr select 0};

{
    if!(_x isEqualTo _Pos)
    then{
            _objDistance = (_Pos Distance2d _x);
            If (_objDistance < _minDistance) 
            then     {
                        _minDistance = _objDistance;
                        _Nearest     = _x;
                    };
        };
} ForEach _ObjArr;


_Nearest