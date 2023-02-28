params["_man", "_building", "_target"];
private _buildingVarName = ["Occupied building ", (name _man), (getPos _building)] joinString "_";
private _path = [_building, true, (getPos _man)] call SFSM_fnc_buildingPath;
private _cPos = 1;
private _startSpeedMode = speedMode _man;
private _startTime = time;


[_man, "action", "Initializing CQB"] call SFSM_fnc_unitData;
[_man, "targetBuilding", _buildingVarName] call SFSM_fnc_unitData;
missionNamespace setVariable [_buildingVarName, _building];

_man setBehaviour "AWARE";
_man setCombatBehaviour "AWARE";
_man setUnitPos "UP";
_man setAnimSpeedCoef SFSM_sprintSpeed;
_man setSpeedMode "FULL";

private _script = [_man,(_path#0), 6, 5] spawn SFSM_fnc_forceMove2;//SFSM_fnc_forceMoveToPos;
waitUntil{scriptDone _script;};

{
  private _endCQB = false;
  
  //exit if the man for some reason is outside of the building after 30 sec.
  if((time-_startTime)>30
  &&{(_man distance2D _building)>SFSM_CQBdistance})
  then{_endCQB = true;};
  
  //if for some reason the soldier runs away from the building
  if((_man distance2D _building)>100)then{_endCQB = true;};
  
  //exit if target is dead and there are no enemies near.
  if((time-_startTime)>15
  &&{(_man distance2D _building)<30
  &&{(count ([_building, (side _man)] call SFSM_fnc_unitsInBuilding)) == 0
  &&{!alive _target
  }}})
  then{
    [_man, "action", "CQB: House is clear!."] call SFSM_fnc_unitData;
    private _script = [_man, _path#((count _path)-1), 6, 5] spawn SFSM_fnc_forceMoveToPos;
    waitUntil{sleep 1; scriptDone _script;};
    _endCQB = true;
  };
  
  if(!alive _man)then{_endCQB = true;};

  if(_endCQB)exitWith{};

  private _script = [_man, _x, 10, 2] spawn SFSM_fnc_clearCQBPos;
  waitUntil{sleep 1; scriptDone _script;};
  

  //action text for debugPurposes
  private _complPath = round((_cPos / (count _path))*100);
  private _actionText = ["CQB: Clearing house ", _complPath, "%"] joinString "";
  [_man, "action", _actionText] call SFSM_fnc_unitData;

  //positions cleared
  _cPos=_cPos+1;

} forEach _path;


[_man, "action", "CQB: Clearing House finished."] call SFSM_fnc_unitData;
sleep 1;
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
missionNamespace setVariable [_buildingVarName, nil];

_man doMove (getPos _man);
[_man] doFollow leader (group _man);
_man setUnitPos "AUTO";
_man setAnimSpeedCoef 1;
_man setSpeedMode _startSpeedMode;
true;