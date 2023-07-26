//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];

//exit if the man is clearing a house.
private _action = [_man, "action"] call SFSM_fnc_unitData;
if("CQB" in _action)exitWith{false;};

private _previousBuilding = [_man, "currentBuilding"] call SFSM_fnc_unitData;
private _currentBuilding = [_man] call SFSM_fnc_currentBuilding;

//exit if unit has not been initialized
if(isNil "_previousBuilding")exitWith{false};

//exit if neither current or previous buildings exists.
if(isNil "_currentBuilding"
&&{_previousBuilding == "none"})
exitWith{false;};

//if no new building, but there was a previous one then delete variable and set current to "none"
if(isNil "_currentBuilding"
&&{(!(_previousBuilding == "none"))})
exitWith{
          missionNamespace setVariable [_previousBuilding, nil, true];
          [_man, "currentBuilding", "none"] call SFSM_fnc_unitData;
          "man left building" call dbgmsg;
          false;
  };



//exit if current and previous buildings are the same.
private _buildingVarName = ["Occupied building ", (name _man), (getPos _currentBuilding)] joinString "_";
if(_previousBuilding == _buildingVarName)
exitWith{true;};



[_man, "currentBuilding", _buildingVarName] call SFSM_fnc_unitData;
missionNamespace setVariable [_previousBuilding, nil, true];
missionNamespace setVariable [_buildingVarName, _currentBuilding];

"man entered building" call dbgmsg;
true;