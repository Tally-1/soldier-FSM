//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: AI clears a building room by room.

// Params: [_man:object (the attacker), _building:object, _target:object (the defender)]

// Return value: none

// Example: [_unitA, _building, _unitB] spawn SFSM_fnc_clearBuilding;


params["_man", "_building", "_target"];
private _startPos  = getPos _man;
private _targetPos = getPosATLVisual _target;
private _buildingVarName = ["Occupied building ", (name _man), (getPos _building)] joinString "_";
private _path = [_building, true, _startPos] call SFSM_fnc_buildingPath;
private _cPos = 1;
private _startSpeedMode = speedMode _man;
private _startTime = time;
private _rigged = _building getVariable ["SFSM_explosiveRigged", false];


// Some buildings have no waypoints hence the path will be a loop of the target-position
if(isNil "_path")      then{_path = [_targetPos, _targetPos, _targetPos];};
if(_path isEqualTo []) then{_path = [_targetPos, _targetPos, _targetPos];};

[_man, "action", "Initializing CQB"] call SFSM_fnc_unitData;
[_man, "targetBuilding", _buildingVarName] call SFSM_fnc_unitData;
missionNamespace setVariable [_buildingVarName, _building];

_man setBehaviour "AWARE";
_man setCombatBehaviour "AWARE";
_man setUnitPos "UP";
_man setAnimSpeedCoef SFSM_sprintSpeed;
_man setSpeedMode "FULL";

[_man,(_path#0), 6, 5] call SFSM_fnc_forcedMove;


{
  private _endCQB = false;
  
  //if someone placed an explosive, get out!
  if(_building getVariable ["SFSM_explosiveRigged", false])
  then{
    [_man, "action", "Get out! house is about to explode"] call SFSM_fnc_unitData;
    _endCQB = true;
  };
  
  //exit if the man for some reason is outside of the building after 30 sec.
  if((time-_startTime)>30
  &&{(_man distance2D _building)>SFSM_CQBdistance})
  then{_endCQB = true;};
  
  //if for some reason the soldier runs away from the building
  if((_man distance2D _building)>100)then{_endCQB = true;};
  
  if(((getPosATL _building)#3)<0)exitWith{_endCQB = true;};
  if ([_man] call SFSM_fnc_isUncon)exitWith{_endCQB = true;};

  //exit if target is dead and there are no enemies near.
  if((time-_startTime)>15
  &&{(_man distance2D _building)<30
  &&{(count ([_building, (side _man)] call SFSM_fnc_unitsInBuilding)) == 0
  &&{!alive _target
  }}})
  then{
    [_man, "action", "CQB: House is clear!."] call SFSM_fnc_unitData;
    ["CQB_houseClear", [_man, _building]] call CBA_fnc_localEvent;
    // private _script = 
    [_man, _path#((count _path)-1), 6, 5] call SFSM_fnc_forceMoveToPos2;
    // waitUntil{sleep 1; scriptDone _script;};
    _endCQB = true;
  };
  
  if(!alive _man)then{_endCQB = true;};
  if(_endCQB)exitWith{};

  // if all checks passed then move to the next position.
  // private _script = 
  [_man, _x, 10, 2] call SFSM_fnc_clearCQBPos;
  // waitUntil{sleep 1; scriptDone _script;};
  

  //action text for debugPurposes
  private _complPath = round((_cPos / (count _path))*100);
  private _actionText = ["CQB: Clearing house ", _complPath, "%"] joinString "";
  [_man, "action", _actionText] call SFSM_fnc_unitData;

  //count positions cleared
  _cPos=_cPos+1;

} forEach _path;


[_man, "action", "CQB: Clearing House finished."] call SFSM_fnc_unitData;
["CQB_clearingEnded", [_man, _building]] call CBA_fnc_localEvent;
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