params["_fipoMen"];
if(_fipoMen isEqualTo [])exitWith{};

{
   private _group = group _x;
   private _leader = leader _group;
   private _fipoGroup = [_group, "fipoGroup"] call SFSM_fnc_groupData;

   if(_leader distance2D _x > SFSM_fipoGetInDistance
   &&{(! _fipoGroup)})then{

      [_x] spawn SFSM_fnc_moveOutFipo;
   
   };
   
} forEach _fipoMen;

true;