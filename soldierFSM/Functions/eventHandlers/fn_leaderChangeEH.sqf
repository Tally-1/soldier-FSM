params["_group"];
_group addEventHandler ["LeaderChanged", {
    params ["_group", "_newLeader"];
   if([_newLeader] call SFSM_fnc_inFipo
   &&{!([_group, "fipoGroup"] call SFSM_fnc_groupData)})then{
      // [_newLeader] call SFSM_fnc_moveOutFipo;
   };
}];