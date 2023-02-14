params["_vehicle"];
if(typeName _vehicle != "OBJECT")exitWith{};
private _gunner = gunner _vehicle;
private _driver = driver _vehicle;
private _targetedBy = _vehicle getVariable ["targetedBy", []];
if(count _targetedBy > 0)exitWith{"car targeted, cannot reinforce"call dbgmsg; false;};
// if((!alive _driver) && {(!alive _gunner)})exitWith{"car has no crew, cannot reinforce"call dbgmsg; false;};
if((alive _driver) && {(!alive _gunner)})exitWith{true;};
if((!alive _driver) && {(alive _gunner)})exitWith{true;};
false;params["_man", "_vehicle"];
if!(SFSM_hearingHide)exitWith{false;};
if!(isEngineOn _vehicle)exitWith{false;};

private _hearingDistance = SFSM_hearingDistance;
private _distance = (_man distance2D _vehicle);
private _areaName = [_man] call Tcore_fnc_areaName;
private _inUrbanArea = (count (_areaName splitString " ")) == 1;

if(_inUrbanArea)then{_hearingDistance = (SFSM_hearingDistance/2);};

if(_distance > _hearingDistance)exitWith{false;};

true;*
Retrieves or stores data from the SFSM_vehicleData hashmap.
_vehicle is the object containing the hashmap-variable
_item is the key-value in the hashmap
_value (optional) is the value to assign to the hashmap-key.
*/
params ["_vehicle", "_item", "_value"]; 

if(isNil "_vehicle")exitwith{};
if([_vehicle]call Tcore_fnc_deadCrew)exitWith{};

private _vehicleData = (_vehicle getVariable "SFSM_vehicleData");
if(isNil "_vehicleData")exitWith{};

private _returnVal = _vehicleData get _item;

if(isNil "_value")exitwith{_returnVal};

_vehicleData set [_item, _value];
_vehicle setVariable["SFSM_vehicleData", _vehicleData, true];

_value;params["_vehicle"];
if(isNil "_vehicle")exitwith{false;};
if(!alive _vehicle)exitwith{false;};
if(!canMove _vehicle)exitwith{false;};
// if(!canFire _vehicle)exitwith{false;}; //(vehicles with no crew returns false on can fire)
if!([_vehicle] call Tcore_fnc_deadCrew)exitwith{false;};
if!((locked _vehicle)in[0,1,3])exitwith{false;};

private _occupiedVehicles = [];
private _vehicleType = [_vehicle] call objScan_fnc_VehicleType;

private _targetedBy = _vehicle getVariable ["targetedBy", []];

if(count _targetedBy>1)exitWith{false;};
if!(_vehicleType in SFSM_hijackVehicleTypes)exitwith{false;};

true;params["_units","_vehicles", "_maxDistance"];
private _unitsInReach = [];
{
	private _nearestVehicle = [_x, _vehicles] call Tcore_fnc_nearestPos;
	if(typeName _nearestVehicle == "object"
	&&{(_nearestVehicle distance2D _x) < _maxDistance})
	then{_unitsInReach pushBack _x;};
	
} forEach _units;

_unitsInReach;params["_battlefield"];
private _unitFilter = { (typeOf _x == (typeOf (vehicle _x))) &&{([_x, "action"]call SFSM_fnc_unitData)=="none"}};
private _units = missionNamespace getVariable (_battlefield get "units") select _unitFilter;
private _pos = _battlefield get "center";
private _radius = _battlefield get "radius";
private _vehicleFilter = {
	private _type = [_x] call objScan_fnc_VehicleType;
	(_type in SFSM_hijackVehicleTypes
	&&{[_x] call SFSM_fnc_vehicleNeedsCrew})
};
private _vehicles = (_pos nearEntities ["car", _radius]) select _vehicleFilter;

{
	private _nearestVehicle = [_x, _vehicles] call Tcore_fnc_nearestPos;
	private _found = typeName _nearestVehicle == "OBJECT";
	private _needsReinforcement = _found && {[_nearestVehicle] call SFSM_fnc_vehicleNeedsCrew};
	private _sameSide = _found && {((side _nearestVehicle) == (side _x))};

	if(_found
	&&{_needsReinforcement
	&&{_sameSide}})
	then{
            private _role = "gunner";
			if(alive (gunner _nearestVehicle))then{_role = "driver"};
            [_x, _nearestVehicle, _role] spawn SFSM_fnc_getInVehicle;
    };

    // if!(_found)then{"Vehicle not found (reinforce)"call dbgmsg;};
	// if!(_needsReinforcement)then{"Vehicle does not need reinforcement"call dbgmsg;};
	// if!(_sameSide)then{"Vehicle not the same side."call dbgmsg;};

	sleep 0.05;
} forEach _units;

true;params["_vehicle", "_man"];

private _currentUnits = _vehicle getVariable ["targetedBy", []];

if(_currentUnits isEqualTo [])exitWith{false;};

private _otherSidePresent = false;

{
	if((side _x) != (side _man))
	exitWith{_otherSidePresent = true;};
	
} forEach _currentUnits;

_otherSidePresent;params["_vehicle", "_man"];

private _actionText = ["Getting vehicle as ", _role, "!"] joinString "";
[_man, "action", _actionText]call SFSM_fnc_unitData;

private _targetedBy = _vehicle getVariable "targetedBy";

if(isNil "_targetedBy")
then{
	_vehicle setVariable ["targetedBy", []];
};
(_vehicle getVariable "targetedBy")pushBackUnique _man;

true;params["_vehicle", "_units"];
private _filter = {((_vehicle distance _x) < SFSM_DodgeDistance)
                &&{[_x, "action"]call SFSM_fnc_unitData == "none"
				&&{[_x, "pathEnabeled"]call SFSM_fnc_unitData
				&&{(!(_x getVariable ["SFSM_Excluded",false]))
				&&{typeOf _x == typeOf (vehicle _x)
				&&{!(_x in allPlayers)}}}}}};

_units = ([_units, [], {_vehicle distance _x }, "ASCEND"] call BIS_fnc_sortBy);
_units = _units select _filter;

if(_units isEqualTo [])exitWith{};

[_vehicle, (_units#0)] spawn SFSM_fnc_getInVehicle;

if(count _units == 1)exitWith{};

[_vehicle, (_units#1), "driver"] spawn SFSM_fnc_getInVehicle;

true;params["_battleField"];
if!(SFSM_hijackVehicles)exitWith{};
if(isNil "_battleField")exitWith{"Battlefield is nil"call dbgmsg;};
private _radius = _battleField get "radius";
private _pos = _battleField get "center";
private _vehicles = [_pos, _radius] call SFSM_fnc_availableVehicles;
if(_vehicles isEqualTo [])exitWith{"no vehicles"call dbgmsg;};
private _units = missionNamespace getVariable (_battleField get "units");
_units = _units select {(([_x, "action"]call SFSM_fnc_unitData)=="none")&&{(typeOf _x)==(typeof (vehicle _x))}};

_units = [_units, _vehicles, SFSM_DodgeDistance] call SFSM_fnc_UnitsNearVehicles;
if(_units isEqualTo [])exitWith{"no near units"call dbgmsg;};

{
	_units = _units select {([_x, "action"]call SFSM_fnc_unitData)=="none"};
	if(_units isEqualTo [])exitWith{"no available units"call dbgmsg;};
	[_x, _units] call SFSM_fnc_hijackVehicle;
	sleep 0.1;
	
} forEach _vehicles;

true;private _role = "gunner";
params["_vehicle", "_man", "_role"];
private _otherSidePresent = [_vehicle, _man] call SFSM_fnc_otherSideInVehicle;
if(_otherSidePresent)exitWith{};

[_vehicle, _man] call SFSM_fnc_initGetInVehicle;
private _vPos = (getPos _vehicle);

private _move = [
			_man,  //unit 
			_vPos,//position 
			30,   //timeout (optional)
			5,    //minimum distance to position in order to complete move. (optional)
			2     // sleep between each repetition of doMove. (optional)
			] spawn SFSM_fnc_forceMoveToPos;

waitUntil{sleep 0.1; scriptDone _move;};

if((!alive _vehicle)
||(!alive _man)
||((_man distance2D _vehicle)>10))exitWith{
	[_vehicle, _man] call SFSM_fnc_endGetInVehicle;
	};


private _gunner = (gunner _vehicle);
private _driver = (driver _vehicle);
if(_role == "gunner"
&&{!alive _gunner})
then{
        _gunner action ["Eject", _vehicle];
		_man assignAsGunner _vehicle;
		_man action ["getInGunner", _vehicle];
};

if(_role == "driver"
&&{!alive _driver})
then{
        _driver action ["Eject", _vehicle];
		_man assignAsDriver _vehicle;
		_man action ["getInDriver", _vehicle];
};

[_vehicle, _man] call SFSM_fnc_endGetInVehicle;
true;params["_vehicle", "_man"];
[_man, "action", "none"] call SFSM_fnc_unitData;
private _arr = (_vehicle getVariable "targetedBy");
(_vehicle getVariable "targetedBy") deleteAt (_arr find _man);
_man doMove (getPos _man);
_man doFollow (leader (group _man));

true;params["_pos", "_radius"];

private _availableVehicles = 
(_pos nearEntities ["car", _radius])
select {[_x] call SFSM_fnc_vehicleAvailable;};


_availableVehicles;{
	
	
	if!([_x] call Tcore_fnc_deadCrew)
	then{[_x] call SFSM_fnc_updateVehicle;};
	
} forEach vehicles;params ['_vehicle'];


private _battleKey = ([_vehicle, "currentBattle"] call SFSM_fnc_vehicleData);
if(isNil "_battleKey")exitWith{};
private _battleField = SFSM_battles get _battleKey;
if(isNil "_battleField")exitWith{[_vehicle, "hiddenPos", []] call SFSM_fnc_vehicleData;};
if!(_battleField get "gridLoaded")exitWith{};

private _grid = missionNamespace getVariable (_battleField get "grid");
        _grid = _grid get "gridPositions";
private _vPos = getPos _vehicle;
private _hiddenPositions = [_vPos, _grid, _vehicle, 2, true] call Tcore_fnc_visibleFromPositions;

[_vehicle, "hiddenPos", _hiddenPositions] call SFSM_fnc_vehicleData;

// private _txt = ['hidden positions = ', (count _hiddenPositions)] joinString '';
// _txt call dbgmsg;{
	if([_x] call SFSM_fnc_isRealMan)
	then{
		private _data 		    = _x getVariable "SFSM_UnitData";
				
		if(isNil "_data")
		then{[_x] call SFSM_fnc_InitMan}
		else{[_x] call SFSM_fnc_HandleSuppression;};

		_x setVariable["SFSM_UnitData", _data, true];
		
		
};
} forEach allUnits;private 
_script = [] spawn SFSM_fnc_unitTasks; waitUntil{scriptDone _script};
_script = [] spawn SFSM_fnc_groupTasks; waitUntil{scriptDone _script};
_script = [] spawn SFSM_fnc_vehicleTasks; waitUntil{scriptDone _script};
// _script = [] spawn SFSM_fnc_deleteDeadData; waitUntil{scriptDone _script};
true;// private _tenSecondTasks = [(SFSM_fnc_unitTasks), (SFSM_fnc_groupTasks)];
private _tenSecondTimer = 0;

while {true}
do {
		if(_tenSecondTimer == 10)
		then{
				private _script = [] spawn SFSM_fnc_tenSecondTasks;
				waitUntil{scriptDone _script};
				_tenSecondTimer = 0;
			};
		
		sleep 1;
		_tenSecondTimer = _tenSecondTimer+1;
	};params ["_man"];
if!([_man] call SFSM_fnc_isRealMan)exitWith{};

//if man is in a vehicle
if!(typeOf (vehicle _man) == typeOf _man)exitwith{};

//no players should be affected by this function
if([_man] call Tcore_fnc_isPlayer)exitWith{};


private _action 	= [_man, "action"] 				call SFSM_fnc_unitData;
private _lastBullet = [_man, "Last_Close_Bullet"] 	call SFSM_fnc_unitData;


if((time - _lastBullet) > 1)	
then{[_man, "roundsPrSecond", 0] call SFSM_fnc_unitData};

[_man, "current suppression", (getSuppression _man)] call SFSM_fnc_unitData;


//sometimes the flinch-action does not exit properly, this is a failsafe
if(((time - _lastBullet) > 3)
&&{_action == "flinch"})
then{[_x, "action", "none"] call SFSM_fnc_unitData};

if((getSuppression _man) < SFSM_ProneTreshHold)
exitwith{
	
//3x spam, because ArmA, some functions do not execute for unknown reasons.
	_man setUnitPos "AUTO";
	_man setUnitPos "AUTO";
	_man setUnitPos "AUTO";
	[_man] call SFSM_fnc_normalizeStance;
	};

if!(_action == "none")exitWith{};

if((getSuppression _man) > SFSM_ProneTreshHold)
then{_man setUnitPos "DOWN"};

true;params["_group"];
private _noActionLowSuppression = true;
private _units = (units _group) select {[_x] call SFSM_fnc_isRealMan};

{
	private _action = [_x, "action"] call SFSM_fnc_unitData;

	if((getSuppression _x) < SFSM_ProneTreshHold)
	then{_noActionLowSuppression = false};
	if(_action != "none")
	then{_noActionLowSuppression = false};

} forEach _units;

if!(_noActionLowSuppression)exitWith{};

_group setCombatMode "YELLOW";

//3x spam, because ArmA, some commands do not execute for unknown reasons
{
	_x setUnitPos "auto";
	_x setUnitPos "AUTO";
	_x setUnitPos "AUTO";
}forEach(units _group);

true;private _ID = 2;

if !(isNil "PR_HC1") then {
    if !(isNull PR_HC1) then {
        if !(isServer) then {
            _ID = [PR_HC1] remoteExec ["SFSM_PR_main_fnc_getOwner",[0,2] select isDedicated];
        };
    };
};

{
    if ( !(local _x) && { !(_x getVariable ["SFSM_Excluded",false]) } ) then {
        if !(isServer) then { [_x,_ID] remoteExec ["SFSM_fnc_setGroupOwner",[0,2] select isDedicated]; } else { _x setGroupOwner _ID; };
    };
    [_x] call SFSM_fnc_InitGroup;
    [_x] call SFSM_fnc_handleGroupStance;
} forEach allGroups;

{ // why is this here a second time? PapaReap
    if ( !(local _x) && { !(_x getVariable ["SFSM_Excluded",false]) } ) then {
        if !(isServer) then { [_x,_ID] remoteExec ["SFSM_fnc_setGroupOwner",[0,2] select isDedicated]; } else { _x setGroupOwner _ID; };
    };

} forEach allGroups;
{
	private _data = _x getVariable "SFSM_UnitData";
	private _killTime = _x getVariable "SFSM_killTime";
	private _valid = ((!isNil "_data")
                   &&{(!isNil "_killTime")
				   &&{(time-_killTime)>300}});
    if(_valid)
	then{
          _x setVariable ['SFSM_killTime', nil, true];
		  _x setVariable ['SFSM_UnitData', nil, true];
	};
	
} forEach alldeadMen;params["_man", "_battleField"];
private _unkillableVehicle = objNull; 
private _enemyVehicles     = [_man, _battleField] call SFSM_fnc_getEnemyVehicles;

if(_enemyVehicles isEqualTo []) exitWith {objNull};

private _highThreatVehicles = [];

{
	private _vehicleData   = [_x] call objScan_fnc_vehicleData;
	private _chassisClass  = (_vehicleData get "chassis") get "chassisID";
	private _weaponClasses = _vehicleData get "weaponTypes";
	private _bestWeapon    = selectMax _weaponClasses;
	private _operational   = !([_x] call Tcore_fnc_deadCrew);

	if(_operational
	&&{_bestWeapon >= 3
	&&{_chassisClass >= 1.2}})
	then{_highThreatVehicles pushBackUnique _x};

} forEach _enemyVehicles;


if(_highThreatVehicles isEqualTo []) exitWith {objNull};

_unkillableVehicle = [_man, _highThreatVehicles] call Tcore_fnc_nearestPos;

if(typeName _unkillableVehicle == "SCALAR")exitWith{objNull};

_unkillableVehicle;*
This function is useless, only keep it as a possible future project to work on.
Main reason is that SQF does not allow for this type of move.

*/

params["_man", "_enemies"];

if(isNil "_enemies")    then {_enemies = [_man] call Tcore_fnc_nearKnownEnemies};
if(count _enemies == 0) exitWith {"no enemies found" call dbgmsg};

private _launcher = (secondaryWeapon _man);
if(_launcher == "")exitWith{"no launcher found" call dbgmsg};

private _target = [_man, _enemies] call Tcore_fnc_nearestPos;
private _timer = time +5;

[_man, "action", "Targeting infantry"] call SFSM_fnc_unitData;

_man selectWeapon _launcher;
waitUntil{sleep 0.1; (currentWeapon _man == _launcher or (time > _timer))};

_man doFire _target;
"firing" call dbgmsg;


sleep 5;

[_man, "action", "none"] call SFSM_fnc_unitData;

params ["_man", "_positions"];

private _counter  = 1; 
_positions = _positions select {(_man distance2D _x)<300};
private _posCount = count _positions;
if(_posCount == 0)exitWith{};

// change the format of all positions to ASL for visibility-check and supression-command.
private _ASL_positions = [];
{_ASL_positions pushBackUnique (AGLToASL _x)}forEach _positions;



// sort positions by distance.
_ASL_positions = [_man, _ASL_positions] call Tcore_fnc_sortByDist;

{
	private _movePos = [_man, _x] call SFSM_fnc_findFirePos;
	private _manPos  = _man call Tcore_fnc_getPos;

	//make sure there are enemies left near the target-position.
	private _enemiesOnPos = [_man, 20, true, (ASLToAGL _x)] call Tcore_fnc_nearSoldiers;
	private _doFire = (count _enemiesOnPos > 0);
	if(_doFire)then{

	//move to fire-pos if needed
	if((!(_movePos isEqualTo _manPos))
	&&{!(_movePos isEqualTo [0,0,0])})
	then{
			private _move = [_man, _movePos, _x] spawn SFSM_fnc_moveToFirePos;
			[_man, "action", "Moving to fire-position"] call SFSM_fnc_unitData;
			waitUntil{sleep 1; scriptDone _move;};
			[_man, "action", "none"] call SFSM_fnc_unitData;
	};

	//suppress position
	private _supText = ["Suppressing position ", _counter, " of ", _posCount, "!"] joinString "";
	private _timer = time + 30;
	[_man, "action", _supText] call SFSM_fnc_unitData;
	_man doSuppressiveFire _x;

	waitUntil {sleep 0.1; ((!(currentCommand _man == "Suppress")) or time > _timer);};

	if(!alive _man)exitWith{};

	// reload
	private _reloadNeeded = needReload _man > 0.9;
	if(_reloadNeeded)then{[_man, "action", "reloading!"] call SFSM_fnc_unitData; reload _man; sleep 7;};

	
	};
	_counter = _counter+1;
} forEach _ASL_positions;

[_man, "action", "none"] call SFSM_fnc_unitData;
true;*
	This function is called by battlefieldPostInit. 
	It returns a boolean value, if returnValue is true the unit will do some action defined below

	Hence in order to have the unit execute a special action then make sure you spawn the new action 
	and return true. See lines 19-23 for an example.
*/
params ["_man", "_battlefield"];
private _special = [_man] call SFSM_fnc_squadAsset;
private _player  = [_man] call Tcore_fnc_isPlayer;
private _pathEnabeled = [_man, "pathEnabeled"] call SFSM_fnc_unitData;

if!(_pathEnabeled)       exitWith{false};
if(_player)              exitWith{false};
if(_special == "regular")exitWith{false};
if(_special == "medic")  exitWith{false};

private _grpCanDodge = ([_group] call SFSM_fnc_groupCanDodge);
private _machineGunner = _special == "machineGunner";
private _at_Specialist = _special == "AT-specialist";

if((! _grpCanDodge)
&&{_machineGunner or _at_Specialist})
exitWith{'specialist in playerGroup / zeus' call dbgmsg; false};



if(_machineGunner)
exitWith{
			[_man] spawn SFSM_fnc_machineGunInitFight;
			true;
};

if(_at_Specialist)
exitWith{
			[_man] spawn SFSM_fnc_AtSpecialistInitFight;
			true;
};


false;params ["_man", "_battleField"];

private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")
exitWith{
	"reactToVehicles, action undefined" call dbgmsg;
	false;
	};

private _occupied = ("Hiding" in _action 
                  || "hiding" in _action
				  || "hide" in _action
                  || "Targeting" in _action 
                  || "weapon" in _action 
                  || "holding" in _action);

private _playerLead = ((leader (group _man)) in allPlayers);


if(_occupied)exitWith{false};
 
//get nearest high-level enemy vehicle [_x] call SFSM_fnc_emergencyRearm;
private _majorThreat = [_man, _battleField] call SFSM_fnc_unkillableEnemyVehicle;


//proceed as normal if there are no enemy high-level vehicle
if(isNull _majorThreat)exitWith{false};



//Performance-wise this block would be better to put before the threat-check, 
//however the debug-message might cause confusion for testers if there are no vehicles present at the battlefield
if(_playerLead 
&& {!(SFSM_PlayerGrpDodge)})
exitWith{
			"player groups blocked from dodging, will not hide from vehicles" call dbgmsg; 
			false;
		};


//try to pick up launcher
private _atSpecialist    = ([_man] call SFSM_fnc_squadAsset) == "AT-specialist";
private _hasAtAmmo       = [_man, (secondaryWeapon _man)] call SFSM_fnc_hasAmmoForWeapon;
private _rearming        = false;

if!(_atSpecialist)
then{_rearming = [_man] call SFSM_fnc_emergencyRearm};
if  (_rearming) exitWith{true};


//check visibility / hearing
private _manPos          = eyePos _man;
private _enemyPos        = eyePos _majorThreat;
private _visibleToThreat = ([_man, "VIEW", _majorThreat] checkVisibility [_manPos, _enemyPos]) > 0.1;
private _vehicleHeard    = ([_man, _majorThreat] call SFSM_fnc_vehicleHeard);
private _detected        = (_visibleToThreat || _vehicleHeard);

if(_vehicleHeard)
then{["A vehicle was detected by hearing", 2] call dbgmsg};

//proceed as normal if man cannot be seen by enemy vehicle
if!(_detected)exitWith{false};


//if a vehicle is found and the man has a AT launcher, then repeat init-fight actions
if(_atSpecialist
&&{_hasAtAmmo
&&{SFSM_AtSpecHuntVehicles}})
exitWith{[_man] spawn SFSM_fnc_AtSpecialistInitFight; true};


//if there is a high-level threat present and the man has no launcher or no misiles.

if!(SFSM_hideFromVehicles)exitWith{"Man will not hide, hiding has been deactivated" call dbgmsg; false;};




//check for near available houses to hide in.
private _takeCoverIndoors = false;
private _canDodge = [_man, true] call SFSM_fnc_canDodge;
private _house = [(getPos _man), SFSM_DodgeDistance] call SFSM_fnc_nearestAvailableHouse;
if(_canDodge
&&{!isNil '_house'})
then{
	  
	  private _coverPos = [_man, _house, false, _majorThreat] call SFSM_fnc_moveIntoHouseInit;
	  _takeCoverIndoors = !(_coverPos isEqualTo [0,0,0]);
};

//If house can be used as cover exit here.
if(_takeCoverIndoors)exitWith{true;};


private _hidePos = [_man, _majorThreat] call SFSM_fnc_findHidePos;
private _posFound = typeName _hidePos == "ARRAY";

if(_posFound)
exitWith{
			[_man, _hidePos, _majorThreat] spawn SFSM_fnc_hideFromVehicle;
			true;
		}; 


//If no hidden positions are found in the battlefield-grid, a standard coverPosition will be used
private _hideDir = _majorThreat getDir _man;
private _searchPos = getPos _man;
_searchPos = [_searchPos#0, _searchPos#1, _hideDir, SFSM_DodgeDistance] call Tcore_fnc_sinCosPos;

_hidePos = [_man, _searchPos, (SFSM_DodgeDistance*2)] call SFSM_fnc_getCoverPos;
_posFound = (!isNil "_hidePos" && {typeName _hidePos == "ARRAY"});

if(_posFound)
exitWith{
			[_man, _hidePos, _majorThreat] spawn SFSM_fnc_hideFromVehicle;
			true;
		};


"No place to hide found, running away from vehicle" call dbgmsg;

if!(surfaceIsWater _searchPos)
exitWith{[_man, _searchPos, _majorThreat] spawn SFSM_fnc_hideFromVehicle; true};

false;private _nearEnemies = [];
params[
	"_man", // the man who will shoot.
	"_movePos", // where he will shoot from 
	"_targetPos"// the position he will shoot at.
	];

_movePos = [_movePos#0,_movePos#1,0];
private _timer = time + SFSM_DodgeTimer;
private _distance = round(_man distance2d _movePos);


if(SFSM_forceDodge)
then{[_man, false] call Tcore_fnc_toggleAiMoveInhibitors};


_man setAnimSpeedCoef SFSM_sprintSpeed;

_man doMove (getPos _man);
_man doMove _movePos;
_man doTarget objNull;


while {sleep 2; _distance > 3} do {
	
	private _killEnemies = [_man, 150] spawn SFSM_fnc_killNearEnemies; 
	waitUntil {sleep 0.5; scriptDone _killEnemies;};

	private _visible = ([(aimPos _man), _targetPos] call Tcore_fnc_visibility) > 0.8;
    private _hasMovedCloser = _distance > ((aimPos _man) distance2d _movePos);
	_distance = ((aimPos _man) distance2d _movePos);

	if!(_hasMovedCloser)
	then{
			_man doMove _movePos;
			_man doTarget objNull;
		};
	

	if(_distance < 3)    exitWith{false};
	if(time > _Timer)	 exitWith{false};
	if(!alive _man)		 exitWith{false};
	if(_visible)         exitWith{false};

};

if(SFSM_forceDodge)
then{[_man, true] call Tcore_fnc_toggleAiMoveInhibitors};

_man setAnimSpeedCoef 1;


_man doMove (ASLToAGL getPosASL _man);
_man doFollow (leader (group _man));

true;params ["_man"];

if!(SFSM_mgSuppressClusters)
exitWith{"initial suppression has been deactivated in CBA options" call dbgmsg};

private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield = SFSM_Battles get _battleKey;

if(isNil "_battlefield")exitWith{};

private _side          = side _man;
private _allClusterPos = (_battlefield get "clusterPositions");
private _coverPos      = [_man] call SFSM_fnc_getCoverPos;
private _coverPosFound = ((!isNil "_coverPos") && {typeName _coverPos == "ARRAY"});

"starting suppression" call SFSM_fnc_debugMessage;




[_man, "action", "!!! Suppressing enemy !!!"] call SFSM_fnc_unitData;

private _enemyClusterPositions = [_side, _battlefield] call SFSM_fnc_getEnemyPositions;
private _script = [_man, _enemyClusterPositions] spawn SFSM_fnc_supressPositions;
waitUntil {sleep 0.5; scriptDone _script};

if(isNil "_battlefield")exitWith{[_man, "action", "none"] call SFSM_fnc_unitData};

//move to coverposition if possible
if(! _coverPosFound)
then{
		_coverPos      = [_man] call SFSM_fnc_getCoverPos;
		_coverPosFound = ((!isNil "_coverPos") && {typeName _coverPos == "ARRAY"});
	};
	
if(_coverPosFound
&&{_man distance2D _coverPos > 2.5})
then{
		[_man, "action", "Suppressing and Moving"] call SFSM_fnc_unitData;
		_script = [_man, _coverPos, 3] spawn SFSM_fnc_forceMoveToPos;
		waitUntil {sleep 1; scriptDone _script};
	};
	
sleep 2;

[_man, "action", "Suppressing enemy positions"] call SFSM_fnc_unitData;

if(isNil "_battlefield")exitWith{[_man, "action", "none"] call SFSM_fnc_unitData};

//now suppress every single enemy individually
private _radius = _battlefield get "radius";
private _allEnemyPos = [_man, (_radius*2)] call Tcore_fnc_nearKnownEnemies;
private _script = [_man, _allEnemyPos] spawn SFSM_fnc_supressPositions;
waitUntil {sleep 0.5; scriptDone _script};

if(isNil "_battlefield")exitWith{[_man, "action", "none"] call SFSM_fnc_unitData};

if(_coverPosFound
&&{_man distance2D _coverPos > 2.5})
then{
		[_man, "action", "Suppressing and Moving"] call SFSM_fnc_unitData;
		_script = [_man, _coverPos, 3] spawn SFSM_fnc_forceMoveToPos;
		waitUntil {sleep 1; scriptDone _script};
	};

"machineGunner ended suppression of enemy" call SFSM_fnc_debugMessage;
[_man, "action", "none"] call SFSM_fnc_unitData;
_man doFollow leader (group _man);

[_man] call SFSM_fnc_postCoverActions;
true;params ["_man", "_battlefield"];

private _vehicles = missionNamespace getVariable (_battlefield get "vehicles");

if((count _vehicles) == 0)exitWith{[]};

private _side           = side _man;
private _enemyVehicles  = [];


{
	private _thisSide = side _x;
	private _enemy    = !([_Side, _thisSide] call BIS_fnc_sideIsFriendly);
	private _crewAlive= ! ([_x] call Tcore_fnc_deadCrew);

	if(_enemy
	&&{_crewAlive
	&&{!(_thisSide == civilian)}})
	then{_enemyVehicles pushBack _x};

} forEach _vehicles;

_enemyVehicles;params ["_man", "_targetPosASL"];

if(typeName _targetPosASL == "object")
then{
	    _targetPosASL = [(getPosASLVisual "object"), 1.5] call Tcore_fnc_addZ;

};

private _visibility = ([(aimPos _man), _targetPosASL] call Tcore_fnc_visibility);
if(_visibility >= 0.8)exitWith{(_man call Tcore_fnc_getPos)};

private _midPos = [(getPosASL _man), _targetPosASL] call Tcore_fnc_getMidpoint;
private _radius = _midPos distance2d _man;
private _searchPositions = [_midPos, _radius, 30, 1.5] call Tcore_fnc_squareGrid;
_searchPositions = [_man, _searchPositions] call Tcore_fnc_sortByDist;

private _firePos = [0,0,0];

{
	private _searchPos = AGLToASL _x;
	private _visibility = ([_searchPos, _targetPosASL] call Tcore_fnc_visibility);
	if(_visibility >= 0.4)exitWith{_firePos = _searchPos;};
	
} forEach _searchPositions;

_firePos;private _grenadePanic = false;
params["_man", "_grenadePanic"];
private _leader = ((leader (group _man)) == _man);

if(_leader&&{!(_grenadePanic)})exitWith{true};

private _loadout = getUnitLoadout _man;

removeAllWeapons _man;

[_man, "action", "No cover panic!"]	call SFSM_fnc_unitData;

_man switchMove "ApanPercMstpSnonWnonDnon_ApanPknlMstpSnonWnonDnon";
_man playMove 	"ApanPpneMstpSnonWnonDnon_G02";
sleep 5;

if!(alive _man)exitWith{[_man, "action", "none"] call SFSM_fnc_unitData};

_man switchMove "AmovPpneMstpSrasWrflDnon_AmovPpneMstpSrasWpstDnon";
_man setUnitLoadout _loadout;
[_man, "action", "none"] call SFSM_fnc_unitData;

private _enemy = ([_man, 300, 'enemies'] call Tcore_fnc_nearKnownEnemies)#0;
if!(isNil "_enemy")then{[_man, _enemy] call SFSM_fnc_Dodge};

true;params ["_man"];
private _battleKey     = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield   = SFSM_Battles get _battleKey;
private _gridPositions = (missionNamespace getVariable (_battlefield get 'grid')) get "gridPositions";
private _enemyVehicles = [_man, _battlefield] call SFSM_fnc_getEnemyVehicles;
private _enemies       = [_man] call Tcore_fnc_nearKnownEnemies;
private _noAtAmmo      = !([_man, (secondaryWeapon _man)] call SFSM_fnc_hasAmmoForWeapon);
private _noEnemyVeh    = count _enemyVehicles == 0;


if(_noEnemyVeh
|| (_noAtAmmo))
exitWith{
			private _text = "No enemy vehicles";
			if(_noAtAmmo)then{_text = "No ammo for launcher"};
			
			[_man, _battlefield, _text] 
			spawn	{
						params ["_man", "_battlefield", "_text"];
						[_man, "action", _text] call SFSM_fnc_unitData;
						sleep 3;
						[_man, "action", "none"] call SFSM_fnc_unitData;
						[_man, _battlefield]  call SFSM_fnc_fightInitCover;
					};
		};


private _targetVehicle = [_man, _enemyVehicles] call Tcore_fnc_nearestPos;
private _timer = time + 30;

[_man, "action", "Targeting vehicle"] call SFSM_fnc_unitData;
_man doTarget objnull;
_man reveal [_targetVehicle, 4];
_man doTarget _targetVehicle;

while{
		sleep 3; 
		private _crewPresent    = !([_targetVehicle] call Tcore_fnc_deadCrew);
		private _hasAtAmmo      = ([_man, (secondaryWeapon _man)] call SFSM_fnc_hasAmmoForWeapon);

		(time < _timer 
		&& {alive _man
		&&{_crewPresent
		&&{_hasAtAmmo}}})
	}
do{
		_hasAtAmmo = ([_man, (secondaryWeapon _man)] call SFSM_fnc_hasAmmoForWeapon);
		if!(_hasAtAmmo) exitWith {};
		
		if!(assignedTarget _man == _targetVehicle)
		then
		{
			_man doTarget objnull;
			sleep 0.1;
			_man doTarget _targetVehicle;

			//the selectWeapon command is buggy, and will usually only work on players...
			if((currentWeapon _man) != (secondaryWeapon _man))
			then{_man selectWeapon (secondaryWeapon _man); sleep 1};

			_man doFire _targetVehicle;
		};
		
		if!([_man, _targetVehicle] call SFSM_fnc_targetVisible)
		then{
				private _hiddenPos = (_targetVehicle getVariable "SFSM_vehicleData")get "hiddenPos";
				if(isNil '_hiddenPos')exitWith{};
				if(isNil '_gridPositions')exitWith{};
				if(typeName _hiddenPos != 'ARRAY')exitWith{};
				private _firePositions = _gridPositions select {! (_x in _hiddenPos)};
				private _nearest =  ([_firePositions, [], {_man distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;
				
				if!(isNil '_nearest')then{_man doMove _nearest;};
		}
		else{
				if((currentWeapon _man) != (secondaryWeapon _man))
				then{_man selectWeapon (secondaryWeapon _man); sleep 1};

				_man doFire _targetVehicle;
		};
		


		sleep 3;
	};


[_man, "action", "none"] call SFSM_fnc_unitData;
_man doMove (getPos _man);
_man doFollow leader (group _man);

[_man] call SFSM_fnc_postCoverActions;params ["_unit"];
private _vdir = _unit weaponDirection (currentWeapon _unit); 
private _adir= _vdir # 0 atan2 _vdir # 1;
_adirprivate _shots 	 = 1;
private _maxTime = 3;
private _rps 	 = 7;//rounds pr second default
params[
		"_shooter", 
		"_target", 
		"_maxTime",
		"_weapon",
		"_shots",
		"_rps"		
	  ];

if(isNil "_weapon")then{_weapon = currentWeapon _shooter};

private _sleep 		= _rps / 1;
private _aimTime	= (_shots / _maxTime) - _sleep;
private _endTime 	= time + _maxTime;

_shooter doWatch  	_target;
_shooter doTarget 	_target;
_shooter doFire		_target;

for "_i" from 1 to _shots 
do {		
		private _timer = time + _aimTime;
		private _timedOut = false;

		waitUntil { 
					private _onTarget = [_shooter, _target] call SFSM_fnc_unitAimedAtTarget;
					_timedOut = time > _timer;
					
					if(_onTarget)exitwith{_shooter forceWeaponFire [_weapon, "single"]; true};
					if(_timedOut)exitwith{_shooter doWatch  _target; true};
					sleep 0.02;
					false
				  };
		if(_timedOut)then{_shooter doFire _target};
		
		_shooter doWatch  _target;
		sleep _sleep;
		if(time > _endTime)exitWith{};
	};

_shooter doWatch  objNull;
_shooter doTarget objNull;
// _shooter doFire   _target;
// _shooter fireAtTarget [_target, _gLauncher];
// _shooter doWatch  _target;
// _shooter doTarget _target;
true;private _vectorCalc 	= false;
private _maxDeviation 	= 3;
params["_shooter", "_target", "_maxDeviation", "_vectorCalc"];
private _dir 		= [_shooter] call SFSM_fnc_unitWeaponDir;
private _targetDir 	= (_shooter getRelDir _target) + _dir;

private _trueAim = [_dir, _targetDir] call Tcore_fnc_inDirRange; 

_trueAimparams ["_man", "_target"];

if(isNil "_target")			exitWith{};
if(isNil "_man")			exitWith{};
if!(_target isKindOf "man")	exitWith{};
if!(_man isKindOf "man")	exitWith{};


private _knowledge		= _man knowsAbout _target;
private _targetVerified	= _knowledge == 4;

private _interSectObjTorso	= lineIntersectsWith [(eyePos _man), (aimPos _target), _man, _target, false];
private _interSectObjHead	= lineIntersectsWith [(eyePos _man), (eyePos _target), _man, _target, false];

private _hasLineOfSight		= (_interSectObjTorso isEqualTo [] 
							or _interSectObjHead  isEqualTo []);


if(alive _target
&&{_targetVerified
&&{_hasLineOfSight}})exitWith{[_man, _target] call SFSM_fnc_directReactFire};



//30% chance of shooting anyway if enemy cannot be seen.
private _shootAnyway = (random 1)>0.7; 
if!(_shootAnyway)exitWith{};
if((typeName _target) == "BOOL")exitWith{systemChat "..."};

//Shoot in the middle of enemy group 
private _targetPos = ([_target, 50] call Tcore_fnc_clusterPos);
if(isNil "_targetPos")then{_targetPos = getPos _target};

_targetPos = AGLToASL _targetPos;

[_man, "action", "return fire"]	call SFSM_fnc_unitData;
_man doSuppressiveFire _targetPos;
waitUntil {sleep 0.1; !(currentCommand _man == "Suppress")};



//finalize return-fire
[_man] call SFSM_fnc_endReactiveFire;params["_unit", "_muzzle", "_weapon"];

private _firing = _unit getVariable "SFSM_RFmultiplier";
if(!isNil "_firing")exitWith{};
_unit setVariable ["SFSM_RFmultiplier", true, true];

private _weaponData = [_weapon] call ObjScan_fnc_weaponData;
private _weaponMode = currentWeaponMode (currentWeapon _unit);
private _rps 		= _weaponData get "RPS";
private _sleep		= (1 / _rps) * 2;

for "_I" from 0 to 2
do{
	sleep _sleep;
	_unit forceWeaponFire [_weapon, _weaponMode];
}

_unit setVariable ["SFSM_RFmultiplier", nil, true];params["_unit", "_muzzle", "_weapon"];

private _action = [_unit, "action"] call SFSM_fnc_unitData;
private _fireActions = ["return fire", "return direct fire"];
if(_action in _fireActions)then{[_unit, _muzzle, _weapon] spawn SFSM_fnc_multiplyRF};
true;params ["_man"];
private _timer = time + SFSM_reactFireCoolDown;
_man doWatch  objNull;
[_man, "reactFireTimer", _timer]	call SFSM_fnc_unitData;
[_man, "action", "none"]			call SFSM_fnc_unitData;
true;params ["_man", "_target"];
private _actionTimer   = time + 3;
private _weapon        = currentWeapon _man;
private _weaponData	   = [_weapon] call ObjScan_fnc_weaponData;
private _grenadeMuzzle = [_weapon] call SFSM_fnc_glRifle;
private _glMuzzleName  = _grenadeMuzzle # 0;
private _glAmmoCapacity= _grenadeMuzzle # 1;
private _hasGl         = !(_glMuzzleName == "");
private _weaponModes   = _weaponData get "weapon-modes";
private _fireMode	   = "";

[_man, "action", "return direct fire"]	call SFSM_fnc_unitData;
_man doTarget _target;

if(_hasGL)
then{
		private _script = [_man, _target, 3, _glMuzzleName, _glAmmoCapacity] spawn SFSM_fnc_unitTounitForcedFire;
		waitUntil {sleep 0.1; scriptDone _script};
	};


if("Full" in _weaponModes)	then{_fireMode = (_weaponModes get "Full") get "cfgName"};
if("Burst" in _weaponModes)	then{_fireMode = (_weaponModes get "Burst") get "cfgName"};
if!(_fireMode == "")		then{_man selectWeaponTurret [_weapon, [], _weapon, _fireMode]};





while{(alive _man
&&{time < _actionTimer})}
do	{
		private _timeLeft = (_actionTimer - time);
		[_man, _target, 1, _weapon, 1] spawn SFSM_fnc_unitTounitForcedFire;
		
		if(!alive _target)then{_target = _man findNearestEnemy _man};
		if(isNull _target)exitWith{};

		_man doWatch  _target;
		_man doFire	  _target;

		sleep 0.1;
	};

[_man] call SFSM_fnc_endReactiveFire;params ["_man"];
if(isNil "_man")exitWith{false};

private _reactFireTimer	= [_man, "reactFireTimer"] 	call SFSM_fnc_unitData;
private _action 	 	= [_man, "action"] 	 		call SFSM_fnc_unitData;
private _rps 	 		= [_man, "roundsPrSecond"] 	call SFSM_fnc_unitData;

(_rps < SFSM_RpsDodgeTrigger
&&{_reactFireTimer < time
&&{(_action == 'none')}})params ["_man", "_grenade", "_velocity", "_source"];
private _animation = "AwopPercMstpSgthWrflDnon_End1";

if(stance _man == "CROUCH")then{_animation = "AwopPknlMstpSgthWrflDnon_End";};
if(stance _man == "PRONE") then{_animation = "AwopPpneMstpSgthWrflDnon_End";};

for "_i"from 0 to 1 do {
_man setDir (_man getDir _source);
sleep 0.02;
};


_grenade attachTo [_man, [0,0,0.1], "rwrist", true];
_man switchMove _animation;
sleep 0.3;
detach _grenade;
_grenade setPosASL eyePos _man;
_grenade setDir (getDir _man);
sleep 0.02;
_grenade setVelocityModelSpace [_velocity#0, _velocity#1, ((_velocity#2)*2)];params ["_man", "_launchPos", "_impactPos", "_shooter"];

if!(_man getVariable ['SFSM_excluded', false])exitWith{false;};
if!([_man] call SFSM_fnc_isRealMan)exitWith{false;};

private _minRadius = 10;
private _flinchRadius = 60;
private _notInBattle = (([_man, "currentBattle"] call SFSM_fnc_unitData) == "none");
private _distanceToImpact = _impactPos distance2D _man;
private _outOfMinRad      = _distanceToImpact > _minRadius;
private _flinch           = ((_distanceToImpact < _flinchRadius) && {_outOfMinRad});
private _takeCover        = (_notInBattle && {_outOfMinRad && {! _flinch}});

if (_flinch) 
then {[_man, _launchPos, _shooter] spawn SFSM_fnc_bigFlinchCover;};


if(_takeCover)
then{[_man, _launchPos] call SFSM_fnc_eventTriggeredCover;};

true;params ["_grenade", "_source"];

["grenade thrown", 2] call dbgmsg;

private _velocity = velocityModelSpace _grenade;
sleep 1;
private _timer = time + 3;

waitUntil {
		private _touchingGround = ((getPos _grenade)#2) < 0.1;
		private _stopped = speed  _grenade < 0.1;
		((_touchingGround
		&&{_stopped})
		|| (time > _timer));
	};

private _nearSoldiers = ([_grenade, ([_grenade, 30] call Tcore_fnc_nearSoldiers)] call Tcore_fnc_sortByDist);
if(count _nearSoldiers == 0)exitWith{};

private _nearest = _nearSoldiers#0;
private _canThrowBack = (_nearest distance2D _grenade)<7;

if(_canThrowBack)
then{
	_nearSoldiers = _nearSoldiers select {_x != _nearest};
	[_nearest, _grenade, _velocity, _source] spawn SFSM_fnc_throwBackGrenade;
	};

if(count _nearSoldiers == 0)exitWith{};

{
	[_grenade, _x, 30, true] spawn SFSM_fnc_evadeGrenade;
	
} forEach _nearSoldiers;

true;params ["_launchPos", "_impactPos", "_shooter", "_ammoType"];
private _nearMen = [_shooter, SFSM_explosionCoverRad] call Tcore_fnc_nearSoldiers;




if(isNil "_shooter")exitWith{"shooter undefined" call dbgmsg};
if(_nearMen isEqualTo [])exitWith{"Nobody insde range of explosion" call dbgmsg};

{
	[_x, _launchPos, _impactPos, _shooter] call SFSM_fnc_reactToExplosion

} forEach _nearMen;

// private _text = ["projectile exploded ", (_launchPos distance2D _impactPos), "m from launch position"] joinString "";
// _text call dbgmsg;
true;params ["_launchPos", "_impactPos"];
//handle overflow
if(time - SFSM_lastImpactHandler < 10)exitWith{};

//this function is ment to help survive snipers, 
//hence the distance needs to be high.
//Lowering the distance could lead to performance issues.
private _distance = _launchPos distance2D _impactPos;
if(_distance < 400)exitWith{};

//convert to AGL format
_launchPos = ASLToAGL _launchPos;
_impactPos = ASLToAGL _impactPos;

//get necesary data and near units.
private _radius = 20;
private _nearMen = [_shooter, _distance] call Tcore_fnc_nearSoldiers;
if(_nearMen isEqualTo [])exitWith{};

//Send all units within set radius into cover / run away from impact
private _unitsReacted = 0;
{
	private _action      = [_X, "action"]        call SFSM_fnc_unitData;
	private _lastCover   = [_x, "last_time_in_cover"] call SFSM_fnc_unitData;
	private _noCoverSpam = (time - _lastCover) > (SFSM_stayCoverPosTime + 60);
	private _notInBattle = (([_X, "currentBattle"] call SFSM_fnc_unitData) == "none");

	if(_action == "none"
	&&{_noCoverSpam
	&&{_notInBattle
	&&{!(_man getVariable ['SFSM_excluded', false])}}})
	then{
			[_x, _launchPos] call SFSM_fnc_eventTriggeredCover;
			_unitsReacted = _unitsReacted+1;
		};

} forEach _nearMen;

if(_unitsReacted > 0)then{[[_unitsReacted, "units hiding from bulletImpac"]] call dbgmsg};

//update impactHandler to avoid overflow / performance issues.
SFSM_lastImpactHandler = time;

true;private _allowPanic = false;
params ["_grenade", "_man", "_distance", "_allowPanic"];

[_man, "action", "Evading grenade"]	call SFSM_fnc_unitData;

private _tim3r = time +5;
private _evasionDir = (_man getDir _grenade)-180;

_man setDir _evasionDir;
_man playMoveNow "AmovPercMevaSrasWrflDf";

sleep 0.621;

while{_tim3r > time}
do{
	_man playMove "AmovPercMevaSrasWrflDf";
	if (speed _man == 0
	&& {_tim3r - time < 4})
	exitWith{};
	sleep 0.621;
};

if(_man Distance2d _grenade < _distance)
then{
		private _panic = [_man, true] spawn SFSM_fnc_eyelidTrench;
		waitUntil { scriptDone _panic; };
};

[_man, "action", "none"]	call SFSM_fnc_unitData;

true;params["_impactPos", "_ammoType"];
private _touchingGround = (ASLToAGL _impactPos)#2 < 0.5;
private _recentCrater = (time - SFSM_lastCrater) < 1;

if!(_touchingGround)exitWith{};
if(_recentCrater)exitWith{};


private _ammoData = [_ammoType] call objScan_fnc_getAmmoData;
private _class  = _ammoData get "class ID";
private _mediumExplosive = _class >= 5 && {_class <= 7.3};
private _highExplosive = _class > 7.3 && {_class < 9.1};
private _terrainReduction = 0.5;
private _radius = 3;


if(_mediumExplosive)then{
	_terrainReduction = 1;
	_radius = 6;
	};
if(_highExplosive)then{
	_terrainReduction = 1.5;
	_radius = 12;
	};

private _height = getTerrainHeight _impactPos;
private _newHeight = _height - _terrainReduction;


private _objectTypes = ["Bush", "FENCE", "SMALL TREE", "TREE", "WALL", "ROCKS", "ROCK", "ROAD"];
private _objects = nearestTerrainObjects [(ASLToAGL _impactPos), _objectTypes, _radius];
{[_x, true] remoteExec ["hideObject", 0]} forEach _objects;
[["objects: ", (count _objects)]]call dbgmsg;

sleep 0.1;
setTerrainHeight [[[_impactPos#0,_impactPos#1, _newHeight]], true];
sleep 0.1;
//the following is taken from Havocs simple craters mod.
//https://steamcommunity.com/sharedfiles/filedetails/?id=2853200431

private _ATLpos = ASLToATL _impactPos;
{
	private _decal = createSimpleObject [_x, [_ATLpos#0, _ATLpos#1, 0]];
	_decal setDir (random 360);
} foreach ["Land_DirtPatch_03_F", "Land_ClutterCutter_large_F"];

SFSM_lastCrater = time;*
*  initSettings.sqf
*  Author: PapaReap
*  Extension of  "\soldierFSM\Functions\init\initSettings.sqf"
*/



*
*  customCBA.sqf
*  Author: PapaReap
*/

private _versionName = ["DCO soldier FSM V. ", (missionNamespace getVariable "SFSM_Version")] joinString "";

[
    "PR_Allow_HC",
    "CHECKBOX",
    ["Allow Headless Client", "Allow Headless Client to process SFSM for AI."],
    _versionName,
    false,
    true,
    {},
    true
] call cba_settings_fnc_init;

[
    "PR_Use_HC",
    "CHECKBOX",
    ["Use Headless Client", "Use Headless Client to process SFSM for AI."],
    _versionName,
    false,
    true,
    {},
    true
] call cba_settings_fnc_init;

[
    "PR_HC1",
    "EDITBOX",
    ["Headless Client name", "Headless Client name, default HC"],
    _versionName,
    "HC",
    true,
    {},
    true
] call cba_settings_fnc_init;
params ["_object"];
private _terrainObjData = createHashmap;
private _typeName       = [_object] call Tcore_fnc_simpleObjectType;
private _3dData         = [_object] call Tcore_fnc_object3DShape;
private _properties     = (createHashMapFromArray namedProperties _object);
private _ownerUnit      = "";

_terrainObjData set ["type", _typeName];
_terrainObjData set ["3dData", _3dData];
_terrainObjData set ["properties", _properties]; 

_terrainObjDataparams["_man"];
private _infantryData    = [_man] call objScan_fnc_infGearData;
private _weaponClass     = (_infantryData get "weaponData") get "primary" get "class ID";
private _unitDescription =  _infantryData get "description";
private _AT_strings      = ["RPG", "AT-misile"];
private _ATspecialist    = false;

{if(_x in _unitDescription)exitWith{_ATspecialist = true}} forEach _AT_strings;


private _machineGunner = ((_weaponClass > 2.5 && {_weaponClass < 4})
						or(_weaponClass >= 1.7 && {_weaponClass <= 1.8}));

private _medic         = "Medikit" in (items _man);



if(_ATspecialist) exitWith{"AT-specialist"};
if(_machineGunner)exitWith{"machineGunner"};
if(_medic)        exitWith{"medic"};


"regular"//checks the height of an object in order to determine which stance a man should take to get proper cover behind said object.
//returns 0-2. 0 = stand. 1 = crouch. 2 = prone.
params["_object"];
private _objData = [_object] call Tcore_fnc_object3DShape;
private _height  = _objData get "height";
private _stance  = 0;

if(_height < 1.6)then{_stance  = 1};
if(_height < 0.9)then{_stance  = 2};
_stanceparams["_man", "_weapon"];
private _hasAmmo       = false;
private _weaponData    = [_weapon] call objScan_fnc_weaponData;
private _magazineTypes = _weaponData get "magazines";
private _unitMags      = soldierMagazines _man;
private _primaryMags   = primaryWeaponMagazine  _man; 
private _secondaryMags = secondaryWeaponMagazine _man; 

_unitMags append _primaryMags;
_unitMags append _secondaryMags;

// private _ammoInweapon = currentMagazineDetail _man;
{
	if(_x in _magazineTypes)
	exitWith{_hasAmmo = true};
} forEach _unitMags;

_hasAmmo;//Searches for Gl-muzzle on a infantry rifle, returns CFG_name of muzzle and mag capacity
params ["_weapon"];
private _weaponData	   = [_weapon] call ObjScan_fnc_weaponData;
private _weaponMuzzles = _weaponData get "muzzles";
private _gLauncher     = "";
private _hasGL         = false;
private _glMagSize     = 0;


if(count _weaponMuzzles > 0)
then{
		
		{
			
			if(typeName _y == "HASHMAP")
			then{
					_gLauncher	= _x;
					_hasGL 		= 3 in (_y get "ammoClasses");
					_glMagSize  = _y get "max-Ammo-Cap";
				};

			if(_hasGL)exitWith{};
			
		} forEach _weaponMuzzles;
		
	};

[_gLauncher, _glMagSize]private _radius = 500;
private _types  = [];
private _lightScan = false;
params ["_pos", "_radius", "_mapObjsData", "_areaData", "_types", "_lightScan"];

private _mapObjectsData = createHashmap;
private _hunkerObjData  = createHashmap;
private _scheduled      = !canSuspend;
private _buildings      = [];
private _posList        = [];
private _hunkerObjects  = [];
private _startTime      = time;
private _terrainObjects = nearestTerrainObjects [_pos, _types, _radius, false, true];
private _nonTerrainStructures = _pos nearObjects ["building", _radius];


private _countAll = count _terrainObjects;
_terrainObjects insert [0, _nonTerrainStructures, true];
private _addedObjs = (count _terrainObjects) - _countAll;
if(_addedObjs > 0)then{[[_addedObjs, " objects was added to battlefield"],2]call dbgmsg;};

_countAll = count _terrainObjects;




if!(_lightScan)then{
	  if(!isNil "_areaData")
	  then{_areaData set ["currentAction", 'Filtering mapobjects'];};

	  _terrainObjects = [_terrainObjects, _scheduled] call SFSM_fnc_filterMapObjects;
	  
	};


private _count 			= 0;

{	
	if((!isNull _x)
	&&{(!isObjectHidden _x)})
	then{
			private _objData   =  [_x] call SFSM_fnc_terrainObjData;
			private _position  = (ASLToAGL (getPosASLVisual _x));
			private _canHunker = [_objData] call SFSM_fnc_isHunkerObject;
			
			_posList pushback _position;
			_position =(str _position);
			
			_mapObjectsData  set [_position, _objData];
			
			//
			if(!isNil "_mapObjsData")
			then{_mapObjsData set [_position, _objData]};

			if(_canHunker)
			then{
					[_hunkerObjData, _objData] call SFSM_fnc_addHunkerObjData;
					_hunkerObjects pushBackUnique _x;
				};
			
			if(_x isKindOf 'house'
			&&{true//(!isObjectHidden _x)
			&&{count(_x buildingPos -1)>3}})
			then{_buildings pushBackUnique _x};
            

			_count=_count+1;
			
			if(SFSM_debugger
			&&{!isNil "_areaData"})
			then{
				 private _prcCompleted = round((_count/_countAll)*100);
				 private _actionText = ['caching ',_countAll,' terrain-objects... ', _prcCompleted, '%'] joinString '';
				 _areaData set ["currentAction", _actionText];
			};
}} forEach _terrainObjects;

_mapObjectsData set ["objectCount", _count];
private _timeSpent = time - _startTime;


if(!isNil "_areaData")
then{
		_mapObjsData set ["positions", _posList];
		_mapObjsData set ["hunkerObjData", _hunkerObjData];
		private _areaName      = _areaData get "name";
		
		private _mapObjVarName    = [_areaName, "Battle_", "_mapObjects"] call Tcore_fnc_stringToVarName;
		private _hunkObjVarName   = [_areaName, "Battle_", "_hunkerObjects"] call Tcore_fnc_stringToVarName;
		private _buildingsVarName = [_areaName, "Battle_", "_buildings"] call Tcore_fnc_stringToVarName;
		
		missionNamespace setVariable [_mapObjVarName,   _mapObjsData];
		missionNamespace setVariable [_hunkObjVarName,  _hunkerObjects];
		missionNamespace setVariable [_buildingsVarName,_buildings];
		
		_areaData set ["mapObjects", _mapObjVarName];
		_areaData set ["hunkerObjects", _hunkObjVarName];
		_areaData set ["buildings", _buildingsVarName];
		_areaData set ["terrainLoaded", true];
		_areaData set ["currentAction",	"none"];

		// copyToClipboard str _hunkerObjData;
	};

// copyToClipboard str _objTypes;

_mapObjectsDataprivate __includeAll = false;
params["_terrainObjects", "_includeAll"];
// private _allTypes = [];
private _approvedObjects = [];

//delete mapObjects that are hidden, from the array.
_terrainObjects deleteAt (_terrainObjects findIf {isObjectHidden _x});

{
	private _excluded = [_x] call SFSM_fnc_excludedMapObject;
	
	if!(_excluded)
	then{
			private _nearest  = [_X, _approvedObjects] call Tcore_fnc_nearestPos;
			private _found    = !(typeName _nearest == "SCALAR");
			private _distance = 3;

			if(_found)then{_distance = _nearest distance2D _x};
			
			private _push = (_distance > 1 or _includeAll);

			if(_push)
			then{_approvedObjects pushBackUnique _x};
		};
	
}forEach _terrainObjects;

// copyToClipboard str _allTypes;
// [["objectTypes: ", (count _allTypes)]] call Tcore_fnc_debugMessage;

_approvedObjectsparams["_object"];
private _typeName    = [_object] call Tcore_fnc_simpleObjectType;
private _objectShape = [_object] call Tcore_fnc_object3DShape;
private _height      = _objectShape get "height";
private _excluded = false;

if (_height < 0.4)  exitwith{true};
if (_typeName == "")exitWith{true};

{
	
	if(_x in _typeName) 
	exitWith {_excluded = true};

} forEach SFSM_excludedMapObjs;


_excluded;*
LINKS:
https://forums.bohemia.net/forums/topic/229453-accessing-config-properties-of-terrain-objects-with-empty-type-typeof-_obj/
https://community.bistudio.com/wiki/Arma_3:_Named_Properties#damage.2Fdammage
*/
private _radius = 500;
private _getAllmapObjects = false;
private _update = false;
params [
		"_pos", 
		"_radius", 
		"_hashMap",
		"_clustersData",
		"_mapObjsData",
		"_getAllmapObjects", 
		"_update"
		];

if(isNil "_mapObjsData")then{_mapObjsData = createHashmap};

private _areaData = nil;
private _sides = [];
private _westPositions = [];
private _eastPositions = []; 
private _guerPositions = [];

if(!isNil "_hashMap")then{_areaData = _hashMap}
					 else{_areaData = createHashmap};

//areaData here refers to the _battlefield, if called by SFSM_fnc_initBattlefield.
_areaData set ["terrainLoaded", false];

if(!isNil "_clustersData")
then{
		_westPositions = [_clustersData, west] 			call Tcore_fnc_positionsClusterArr;
		_eastPositions = [_clustersData, east] 			call Tcore_fnc_positionsClusterArr;
		_guerPositions = [_clustersData, independent] 	call Tcore_fnc_positionsClusterArr;
		_sides = [_clustersData] 						call Tcore_fnc_ClusterSides;
		
		if!(_update)
		then{[_mapObjsData, _clustersData] call Tcore_fnc_ClusterTerrainObjects};		 
};


private _allPositions  = createHashmap;
_allPositions set ["west", _westPositions];
_allPositions set ["east", _eastPositions];
_allPositions set ["independent", _guerPositions];

private _areaName = [_pos] call Tcore_fnc_areaName;

//see comments at fn_useLightScan.sqf, for an explanation of this part.
private _types = [];
private _lightScan = [_pos, _areaName, _radius] call SFSM_fnc_useLightScan;
private _lightScanText = ["Light area-scan being used at ", _areaName] joinString "";

if(_lightScan)then{_types = SFSM_lightScanTypes};

if(_getAllmapObjects)
then{
		if(_lightScan)then{_lightScanText call dbgmsg};
		[_pos, _radius, _mapObjsData, _areaData, _types, _lightScan] spawn SFSM_fnc_getMapObjects;
	}; 



_areaData set ["name", 				_areaName];
_areaData set ["radius", 			_radius];
_areaData set ["clusterPositions", 	_allPositions];
_areaData set ["sides", 			str _sides];

_areaData//original author: KillZone Kid, the function is found at: https://community.bistudio.com/wiki/lineIntersectsWith
// i did edit it slightly to deal ith undefined values.
// Be aware that all lineIntersects commands are heavy and
// should be used with caution.
lineIntersectsSurfaces [
		getPosWorld _this,
		getPosWorld _this vectorAdd [0, 0, 50],
		_this, objNull, true, 1, "GEOM", "NONE"
	] select 0 params ["","","","_house"];
if (isNil "_house")exitWith{false};
if (_house isKindOf "House") exitWith { true };
false*
Retrieves or stores data from the SFSM_UnitData hashmap.
_man is the object containing the hashmap-variable
_item is the key-value in the hashmap
_value (optional) is the value to assign to the hashmap-key.
*/
params ["_man", "_item", "_value"]; 

if(isNil "_man")exitwith{};
if!(_man isKindOf "man")exitwith{};

private _unitData = (_man getVariable "SFSM_UnitData");

if(isNil "_unitData")
exitWith{
			if(SFSM_Debugger
			&&{([_man] call SFSM_fnc_isRealMan)})
			then{diag_log ([("unitData is nil "), (typeOf _man)])};
			nil
		};

private _returnVal = _unitData get _item;

if(isNil "_value")exitwith{_returnVal};

_unitData set [_item, _value];
_man setVariable["SFSM_UnitData", _unitData];

_value;params["_man", "_target"];
private _visibility = [_man, "VIEW", _target] checkVisibility [(aimPos _man), (aimPos _target)];
private _visible = _visibility == 1;
_visible;params["_man"];
private _unitData 	= 	(_man getVariable "SFSM_UnitData");
		_unitData set 	["current suppression", (getSuppression _man)];
		_man setVariable["SFSM_UnitData", _unitData, true];params["_shooter"];
if(time - SFSM_lastSoundCheck < 10)exitWith{false};

private _handGrenade = "Grenade" in (typeOf _projectile);
if(_handGrenade)exitwith{false};

private _weapon = ([(currentWeapon _shooter)] call BIS_fnc_itemType)#1;
private _hasSilencer = !(((_shooter weaponAccessories currentWeapon _shooter)#0) == "");
private _distance = 300;

switch (_weapon) do {
						case "AssaultRifle": { _distance = 400;};
						case "MachineGun":   { _distance = 600;};
						case "SniperRifle":  { _distance = 800;};
					};

if(_hasSilencer)then{_distance = 100};

private _nearMen = [_shooter, _distance] call Tcore_fnc_nearSoldiers;

{
	private _action = [_X, "action"]        call SFSM_fnc_unitData;
	private _battle = [_X, "currentBattle"] call SFSM_fnc_unitData;

	if(_action == "none"
	&&{_battle == "none"
	&&{!(_man getVariable ['SFSM_excluded', false])}})
	then{
			private _coverPos = [_x] call Tcore_fnc_coverPosSimple;
			if(isNil "_coverPos")exitWith{};
			[_x, _coverPos] spawn SFSM_fnc_takeCover;
		};

} forEach _nearMen;


SFSM_lastSoundCheck = time; 

true; params ["_OrigX", "_OrigY", "_Dir", "_Distance"];
Private _NewX = ((sin _Dir) * _Distance) + _OrigX;
Private _Newy = ((cos _Dir) * _Distance) + _OrigY;

Private _Pos = [_NewX,_NewY, 0];

_Pos*
*  fn_setGroupOwner.sqf
*  Author: PapaReap
*  Function Name: SFSM_fnc_setGroupOwner

*  Changes the ownership of a group (and all its units) to a given client.
*  The group leader must not be a player.
*  This command only works when called from the server.
*  Returns true if locality was changed.
*  For agents use setOwner command.
*  [[group _unit, true], 2] remoteExec ["SFSM_fnc_setGroupOwner",2];
*/


params ["_group","_clientOwner"];

private _addServerUnits = false;

if (typeName _group == "ARRAY") then {
    private _groupArray = _group;
    _group = _groupArray select 0;

    if (count _groupArray > 1) then {
        if (typeName (_groupArray select 1) == "BOOL") then {
            _addServerUnits = _groupArray select 1;
        };
    };
};

_group setGroupOwner _clientOwner; 
{ _x setVariable ["SFSM_ClientOwner", _clientOwner, true]; } forEach (units _group);

if (_addServerUnits) then {
    if (isNil "serverUnits") then { serverUnits = []; };

    { serverUnits pushBackUnique _x; } forEach (units _group);
    publicVariable "serverUnits";
};
private _dir = "random";
params ["_man", "_dir"];

private _rollMoves = ["AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDl", "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDr"];
private _rollMove  = "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDl";//roll left.

if(_dir == "right")	then{_dir = "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDr"};
if(_dir == "random")then{_rollMove = selectRandom _rollMoves};

_man playMove _rollMove;params ["_man", "_ammoCFG", "_shooter"];
if(isPlayer _man)exitwith{};
if!(typeOf (vehicle _man) == typeOf _man)exitwith{};//if man is in a vehicle
if!([_man] call SFSM_fnc_isRealMan)exitWith{};

private _rps 		 = [_man, "roundsPrSecond"] call SFSM_fnc_unitData;
private _suppression = (getSuppression _man);
private _lastBullet	 = [_man, "Last_Close_Bullet"] call SFSM_fnc_unitData;

if((time - _lastBullet) < 1 )
then{_rps = _rps + 1}
else{_rps = 1};

//Store new values into unit-hashMap
[_man, "roundsPrSecond", _rps] 				call SFSM_fnc_unitData;
[_man, "Last_Close_Bullet", time] 			call SFSM_fnc_unitData;
[_man, "current suppression", _suppression]	call SFSM_fnc_unitData;

if(_suppression > SFSM_ProneTreshHold)
then{_man setUnitPos "DOWN"};

//Select course of action
[_man, _ammoCFG, _shooter] call SFSM_fnc_initReaction;
true;params['_man'];
private _nearEnemies = [_man, SFSM_overrunDistance, 'enemies'] call Tcore_fnc_nearKnownEnemies;
private _overRun = count _nearEnemies > 0;

if(_overRun)exitwith{(_nearEnemies#0)};

objNull;params["_man"];
if(isNil "_man")exitWith{false};
if(isNull _man)exitWith{false};

private _unitData = _man getVariable "SFSM_UnitData";
if(isNil "_unitData")exitWith{false};

true;private _timer = time + 5;
params["_man", "_timer"];

private _action   = [_man, "action"] call SFSM_fnc_unitData;
private _timedOut = time > _timer;

if(!alive _man)		 exitwith{true};
if(_timedOut)        exitwith{true};
if(isNil '_action')  exitwith{true};
if(_action == "none")exitwith{true};
false;params["_man", "_radius"];

private _action = [_man, "action"] call SFSM_fnc_unitData;
//get near and visible enemies, sorted by distance.
private _enemies = [_man, (([_man, _radius, true] call Tcore_fnc_nearSoldiers) select {[_man, _x] call SFSM_fnc_targetVisible;})] call Tcore_fnc_sortByDist;
if(count _enemies > 0)
then{
		private _killTimer = time + 5;
		[_man, "action", "!Targeting Enemy!"] call SFSM_fnc_unitData;
		{
			_man doFire _x;

			waitUntil{
					sleep 0.5; 
					_man doFire _x;
					_man doMove (getPos _x);
					((!alive _x)  || 
					(!alive _man) || 
					(time > _killTimer)) 
					};
          
        } forEach _enemies;

		[_man, "action", _action] call SFSM_fnc_unitData;
	};
true;if !(params [
	// Variable name, default value, expected data type
	["_man", objNull, [objNull]]
]) exitWith {false}; // Exit with false if an error occurred or default value was used.

if !(alive _man) exitWith {false};
if !(_man isKindOf "CAManBase") exitWith {false};
private _group = group _man;
if (isNull _group) exitWith {false};
if (side _group == sideLogic) exitWith {false};
private _z = _man Getvariable ["bis_fnc_moduleRemoteControl_owner", ""];
if !(_z isEqualTo "") exitwith {false};

true
// The ammo-class is retrieved using the unit-scanner, see references folder for more info.
// Or go to 
// steamPage: https://steamcommunity.com/sharedfiles/filedetails/?id=2811378998
// GitHub:	   https://github.com/Tally-1/SIG-unitScanner

params	[
			"_man", 
			"_ammoCFG", 
			"_shooter"
		];

// private _action = [_man, "action"] call SFSM_fnc_unitData;
// if!(_action == "none") exitWith{};

private _lastBullet 	= [_man, "Last_Close_Bullet"] call SFSM_fnc_unitData;
private _ammoClass		= ([_ammoCFG] call ObjScan_fnc_getAmmoData) get "class ID";
private _canDodge       = [_man] call SFSM_fnc_canDodge;

if(_canDodge)
exitWith{
			[_man, _shooter] spawn SFSM_fnc_Dodge;
			//private _group = group _man;
			//private _grpDodgeDisabeled = [_group, 'dodgeDisabeled'] call SFSM_fnc_groupData;
			//if(_grpDodgeDisabeled)then{'dodge response is blocked by zeus waypoint' call dbgmsg};
		};

//Any projectile from 9.3mm up to a GBU
private _bigProjectile	= (_ammoClass > 2.2 && {_ammoClass < 9.1});
private _canFlinch		= [_man] call SFSM_fnc_canFlinch;

if(_canFlinch)	exitWith{[_man, _bigProjectile, _shooter] call SFSM_fnc_flinch};




true;params["_man"];
private _data = _man getVariable "SFSM_UnitData";
if(!isNil "_data")exitWith{};

// if(isPlayer _man)exitwith{};

private _unitData = createHashMap;

_unitData set 	["Last_Close_Bullet", 	time];
_unitData set 	["flinching", 			false];
_unitData set 	["dodging", 			false];
_unitData set 	["flinchTimer", 		time];
_unitData set 	["dodgeTimer", 			time];
_unitData set 	["roundsPrSecond", 		0];
_unitData set 	["action", 				"none"];


_man setVariable["SFSM_UnitData", _unitData, true];
[_man] call SFSM_fnc_SuppressedEH;

true;*See unitData for comments */
params ["_group", "_item", "_value"];

private _groupData = (_group getVariable "SFSM_groupData");

if(isNil "_groupData")
exitWith{
		if(SFSM_Debugger)then{diag_log "groupData is nil"};
		// [_group] call SFSM_fnc_initGroup;
		// _this call SFSM_fnc_groupData;
		nil
		};

private _returnVal = _groupData get _item;

if(isNil "_value")exitwith{_returnVal};

_groupData set [_item, _value];
_group setVariable["SFSM_groupData", _groupData, true];

_value;private _maxTime = 30;
private _maxDistance = 1.1;
private _spamTimer = 0.5;
params [
	"_man", 
	"_pos", 
	"_maxTime", 
	"_maxDistance", 
	"_spamTimer"
	];



private _timer = time + _maxTime;
private _distance = round(_man distance2d _pos);

if(SFSM_forceDodge)
then{[_man, false] call Tcore_fnc_toggleAiMoveInhibitors};

_man doMove _pos;
_man doTarget objNull;


while {sleep _spamTimer; _distance > _maxDistance} do {
	

	private _hasMovedCloser = _distance > ((eyePos _man) distance2d _pos);
	_distance = ((eyePos _man) distance2d _pos);

	if!(_hasMovedCloser)
	then{
			_man doMove _pos;
			_man doTarget objNull;
		};
	
	if(_distance < _maxDistance)exitWith{false};
	if(time > _Timer)	        exitWith{false};
	if(!alive _man)		        exitWith{false};

};


if(SFSM_forceDodge)
then{[_man, true] call Tcore_fnc_toggleAiMoveInhibitors};

true;params ["_man", "_target"];

private _targetPos = AGLToASL ([(getPos _target)#0, (getPos _target)#1, 1.6]);
private _hasLOS = ([_man, "VIEW", _target] checkVisibility [(aimPos _man), _targetPos]) > 0.8;

private _distance = (_man distance2D _target);
private _minDistance = 40;

private _formatNumber = { params["_number"];
if(_number < 0)then{_number = (_number - (_number*2));};
_number
};

//this will wheigh the height difference more when sorting.
private _sortingAlgo = {
	private _distance = _man distance _x;
	private _zDiff = ((AGLToASL _x)#2)- ((getPosASLVisual _target)#2);
	_zDiff = [_zDiff] call _formatNumber;

	(_distance + _zDiff)
	};
private _getAltitudeDiff = 
{
	params["_pos1", "_pos2"];
	private _z1 = (AGLToASL _pos1)#2;
	private _z2 = (AGLToASL _pos2)#2;
	private _diff = [(_z1 - _z2)] call _formatNumber;
	_diff;
};


private _altitudeDiff = [(getPos _man), (getPos _target)] call _getAltitudeDiff;
if(_hasLOS
&&{_distance > _minDistance
&&{_altitudeDiff < 2}})exitWith{(getPos _man)};


private _maxDistance = 150;
if(_distance > _maxDistance)then{_distance = _maxDistance;};
if(_distance < _minDistance)then{_distance = _minDistance;};

private _firePos = nil;
private _targetZ = _targetPos#2;
private _posArr = [_targetPos, _distance, 36] call Tcore_fnc_get360Positions;
_posArr = _posArr select {([_x, (getPos _target)] call _getAltitudeDiff) < 3};

if(count _posArr == 0)exitWith{"no positions left for lnchrman"call dbgmsg;nil;};

_posArr = ([_posArr, [], _sortingAlgo, "ASCEND"] call BIS_fnc_sortBy);


{
	private _pos = AGLToASL [_x#0,_x#1,1.5];
	private _hasLOS = ([_man, "VIEW", _target] checkVisibility [_pos, _targetPos]) > 0.8;
	if(_hasLOS)
	exitWith{
		_firePos = ASLToAGL _pos;
	};
	
} forEach _posArr;

if(isNil "_firePos")exitWith{};

_firePos;private _destinations = [];

{
	if([_x] call SFSM_fnc_isRealMan)
	then{
		  private _destination = [_x, "currentDestination"] call SFSM_fnc_unitData;
		  if((!isNil '_destination')
		  &&{!(_destination isEqualTo [0,0,0])})
		  then{_destinations pushBackUnique _destination;};
	}
	
} forEach allUnits;
_destinations;params["_man"];
if(isPlayer _man)exitwith{};
if!(typeOf (vehicle _man) == typeOf _man)exitwith{};//if man is in a vehicle

private _3dPos		= (ASLToAGL getPosASL _man);
private _supp		= [(getSuppression _man), 2]call ObjScan_fnc_Decimals;
private _rps		= [_man, "roundsPrSecond"] 	call SFSM_fnc_unitData;
private _action		= [_man, "action"] 			call SFSM_fnc_unitData;

private _actionTxt   = ["Action: ", _action] 		joinString "";
private _supTxt		 = ["Supression: ", _supp] 		joinString "";
private _incomingTxt = [_rps, " Incoming rounds"] 	joinString "";

private _suppColor 	= [_supp, 0.4, 0.4, 1];
private _actColor	= [0.5,0.6,0.4,1];

private _actionPos 	= [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 2.3)];
private _supPos 	= [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 2.1)];
private _incPos 	= [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 1.9)];

if(isNil "_action")			then{_actionTxt = "unknown"};
if(_action == "flinch")		then{_actColor = [0.9,0.2,0.2,1]};
if(_action == "dodging")	then{_actColor = [0.85,0.4,0,1]};



//incoming bullets
if(_rps > 1)
then{
		drawIcon3D 	[
						"",				//texture (icon type)
						_suppColor,		//color
						_incPos,		//position
						0.2, 			//size X
						0.2, 			//size Y
						0, 	 			//angle
						_incomingTxt, 	//text
						2, 				//shadow
						0.03			//textSize
					];
	};

//suppression level

if(_supp > 0)
then{
drawIcon3D 	[
				"",			
				_suppColor,	
				_supPos,	
				0.2, 		
				0.2, 		
				0, 	 		
				_supTxt, 	
				2, 			
				0.03		
			];
};
//current action
drawIcon3D 	[
				"",			
				_actColor,	
				_actionPos,	
				0.2, 		
				0.2, 		
				0, 	 		
				_actionTxt, 
				2, 			
				0.03		
			];


true;if(!isnil "3DmarkersSFSM")exitWith{};
3DmarkersSFSM = true;

addMissionEventHandler ["Draw3D", {
if(SFSM_Debugger)
then{
		{
			private _close 		=  ((positionCameraToWorld [0,0,0]) distance _x) < 200;
			private _notPlayer 	= !(isPlayer _x);

			if(_close
			&&{_notPlayer})
			then{[_x] call SFSM_fnc_3DdebugText};
			
		} forEach allUnits;
}}];private _type = "hd_dot";
private _text = "";
private _color= "ColorBlack";
private _size = 1;
params["_position", "_text", "_size", "_color", "_type"];

if(isNil "SFSM_debugMarkers")then{SFSM_debugMarkers = []};
private _markerCount = count SFSM_debugMarkers;
private _markerName  = [(round((random 1) * 100000)), "_posMarker_", _markerCount] joinString "";

private _marker = createMarkerLocal [_markerName, _position];

_markerName setMarkerTypeLocal _type;
_markerName setMarkerSizeLocal  [_size, _size];
_markerName setMarkerColorLocal _color;
_markerName setMarkerTextLocal _text;
_markerName setMarkerAlpha 1;

SFSM_debugMarkers pushBackUnique _markerName;

_markerNameparams ["_posArr", "_color"]; 
private _markers = [];

{
	private _marker = [_x, "", 0.4, _color, "mil_end_noShadow"] call SFSM_fnc_posMarker;
	_markers pushBackUnique _marker;
} forEach _posArr;

_markers;private _color = "ColorBlack";
private _brush = "BORDER";
params["_pos", "_radius", "_brush", "_color"];

private _markerName  = [(round((random 1) * 100000)), "_randomCircle"] joinString "";
private _marker = createMarker [_markerName, _pos];

_markerName setMarkerShape "ELLIPSE";
_markerName setMarkerBrush _brush;
_markerName setMarkerSize  [_radius, _radius];
_markerName setMarkerColor _color;
_markerName setMarkerAlpha 1;


_markerNameparams ["_battleField"];
if!(SFSM_Debugger)exitWith{};

private _markers   = [];
private _centerPos = (_battleField get "center");
private _radius    = (_battleField get "radius");
private _areaName  = (_battleField get "name");
private _zones     = (_battleField get "zones");
private _coverPos  = (_battleField get "coverPositions");
private _gridHash  = missionNamespace getVariable (_battleField get 'grid');



private _marker1 = [_centerPos, _radius] call SFSM_fnc_drawCircle;
private _marker2 = [_centerPos, _areaName, 1] call SFSM_fnc_posMarker;
{_markers pushback _x}forEach[_marker1, _marker2];



{
  	private _cMarker = [_x] call Tcore_fnc_ClusterMarker;
	_markers pushback _cMarker;
}forEach _clustersData;



{
	private _color = ["Color",_x] joinString "";
	private _pos   = _y#0;
	private _Radius= _y#1;

	if(count _pos > 2)
	then{
			private _zMarker = [_pos, _Radius, nil, _color] call SFSM_fnc_drawCircle;
			_markers pushBack _zMarker;
		};

} forEach _zones;

if(isNil "_coverPos")    exitWith{_battleField set ["markers", _markers]; _markers};
if(count _coverPos > 100)exitWith{_battleField set ["markers", _markers]; _markers};

{
	private _color = ["Color",_x] joinString "";
	private _newMarkers = [_Y, _color] call SFSM_fnc_drawCoverPositions;
	_markers append _newMarkers;
} forEach _coverPos;


if(!isNil "_gridHash")
then{
		private _hfWest   = _gridHash get 'hiddenFromWest';
		private _hfEast   = _gridHash get 'hiddenFromEast';
		private _hfGuer   = _gridHash get 'hiddenFromGuer';

		{
			private _marker = [_x, "", 0.7, 'colorBlue', "Contact_dot1"] call SFSM_fnc_posMarker;
			_markers pushBackUnique _marker;
		} forEach _hfWest;

		{
			private _marker = [_x, "", 0.7, 'colorRed', "Contact_dot1"] call SFSM_fnc_posMarker;
			_markers pushBackUnique _marker;
		} forEach _hfEast;


		
};

_battleField set ["markers", _markers];

_markers;params["_projectile","_man", "_targetPos"];
		
		if(_targetPos#2 < 1.6)then{_targetPos = [_targetPos#0,_targetPos#1,1.6]};
		
		private _targetDistance = _man distance2D _targetPos;
		private _missileDistance = _man distance2D _projectile;
		private _movement = velocityModelSpace _projectile;
		private _targetZ = round(_targetPos#2);
		_projectile setMissileTargetPos _targetPos;
		[
			_man,
			_missileDistance,
			_targetDistance,
			_projectile,
			_targetPos,
			_targetZ,
			_movement
		] spawn SFSM_fnc_guideMissile;
true;params["_man", "_building"];
private _buildingVarName = ["Occupied building ", (name _man), (getPos _building)] joinString "_";
[_man, "targetBuilding", _buildingVarName] call SFSM_fnc_unitData;
missionNamespace setVariable [_buildingVarName, _building];

//launchPos is defined in the canRpgHouse function.
private _launchPos = [_man, "currentDestination"] call SFSM_fnc_unitData;

if(isNil "_launchPos"
|| _launchPos isEqualTo [0,0,0])
exitWith{"could not find a position to launch from" call dbgmsg;};

[_man, "action", "CQB: Engaging house with launcher"] call SFSM_fnc_unitData;

_man setAnimSpeedCoef SFSM_sprintSpeed;

if((_launchPos distance2D _man) > 3)
then{
	private _move = [
			_man,      //unit 
			_launchPos,//position 
			30,        //timeout (optional)
			2,         //minimum distance to position in order to complete move. (optional)
			3          // sleep between each repetition of doMove. (optional)
			] spawn SFSM_fnc_forceMoveToPos;

	waitUntil{sleep 1.5; scriptDone _move;};
};

_man setAnimSpeedCoef 1;

if(!alive _man)
exitWith{
		"man died before using launcher" call dbgmsg;
		[_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
		missionNamespace setVariable [_buildingVarName, nil];
		[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
	};


private _buildingPos = AGLToASL ([(getPos _building)#0, (getPos _building)#1, 2]);
private _hasLOS = ([_man, "VIEW", _building] checkVisibility [(aimPos _man), _buildingPos]) > 0.8;

if!(_hasLOS)exitWith{
	[_man, "action", "failed to get LOS on the building"] call SFSM_fnc_unitData;
	sleep 3;
	_man doMove (getPos _man);
	_man doFollow (leader(group _man));
	[_man, "action", "none"] call SFSM_fnc_unitData;
	[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
	[_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
	missionNamespace setVariable [_buildingVarName, nil];
	};

_buildingPos = ASLToAGL _buildingPos;
_man doWatch _buildingPos;
_man setVariable ["SFSM_missileTarget", _buildingPos];
sleep 1;
private _dir = (_man getDir _building);
_man setDir _dir;
_man doWatch objNull;
private _doFire = [_man, nil, _dir] spawn SFSM_fnc_forceFireLauncher;
waitUntil{scriptDone _doFire;};

_man setVariable ["SFSM_missileTarget", nil];
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
[_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
_man doMove (getPos _man);
_man doFollow (leader(group _man));
missionNamespace setVariable [_buildingVarName, nil];params ["_man"];
private _handler =
_man addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
	if(_weapon == secondaryWeapon _unit)
	then{
		private _targetPos = _unit getVariable "SFSM_missileTarget";
		_unit setAmmo [currentWeapon _unit, 1];

		if(!isNil "_targetPos")
		then{[_projectile, _unit, _targetPos] call SFSM_fnc_steerMissile;};

		_unit setVariable ["SFSM_launched", true];
		_unit removeEventHandler [_thisEvent, _thisEventHandler];
		"unit fired launcher" call dbgMsg;
	};
}];

_handler;params["_unit","_missileDistance","_targetDistance", "_projectile", "_targetPos", "_targetZ", "_movement"];
private _timer = time + 1;
_projectile setMissileTargetPos _targetPos;
"guiding missile" call dbgmsg;
while {
            //while missile has not yet reached / passed its target. 0.02 = 50FPS(ish).
            sleep 0.02; 
            ((_missileDistance < _targetDistance)
            &&{alive _projectile
			&&{time < _timer}});}
            do {
		    
            //define necesary variables
            _missileDistance = _unit distance2D _projectile;
            private _wantedDir = round(_projectile getDir _targetPos);
		    private _currentDir = round(getDir _projectile);
            private _missileZ = round((getPos _projectile)#2);
            private _reApplyMovement = false;
            // private _currentMovement =  

            // tilt projectile backwards
            if(_missileZ < _targetZ)
            then{
                _projectile setVectorUp [0,-0.5,0.5];
                _reApplyMovement = true;
                };

            //tilt projectile forwards
            if(_missileZ > _targetZ)
            then{
                _projectile setVectorUp  [0,0.33,0.66];
                _reApplyMovement = true;
                };
            
            //set flat tilt(? bad english, sorry---)
            if(_missileZ == _targetZ)
            then{_projectile setVectorUp  [0,0,1];};
            
            //adjust direction
            if((_wantedDir != _currentDir)
			&&{_missileDistance < _targetDistance})
            then{
                sleep 0.02;
                _projectile setDir _wantedDir;
                _reApplyMovement = true;
                };

            //reapply original movement through space, with the altered dir/tilt.
            if(_reApplyMovement)
            then{_projectile setVelocityModelSpace _movement;}
            //if the trajectory is correct, then store the movement, to avoid unatural high speed.
            else{_movement = velocityModelSpace _projectile};
            
		};
_projectile setMissileTargetPos _targetPos;
true;private _actionTxt = "firing launcher!";
params["_man", "_actionTxt", "_wantedDir"];

[_man, "action", _actionTxt] call SFSM_fnc_unitData;

private _handler = [_man] call SFSM_fnc_launcherHandler;
private _launcher = secondaryWeapon _man;
private _mode = (getArray (configFile >> "CfgWeapons" >> _launcher >> "modes"))#0;
private _fired = (_man getVariable ["SFSM_launched", false]);
private _timer = time +5;

waitUntil {

	if(!isNil "_wantedDir"
	&&{(round _wantedDir) != (round(getDir _man))
	&&{(_timer -  time)>= 1}})
	then{_man setDir _wantedDir};

	_man forceWeaponFire [_launcher, _mode];
	_fired = (_man getVariable ["SFSM_launched", false]);
	((time > _timer) || _fired);
	};

sleep 1;

if!(_fired)then{_man removeEventHandler ["FiredMan", _handler];};
_man setVariable ["SFSM_launched", nil];

[_man, "action", "none"] call SFSM_fnc_unitData;params["_man", "_house"];
if!(SFSM_rpgHouse)exitWith{false;};
if(isNil "_man")exitWith{false;};
if!([_man] call SFSM_fnc_isRealMan)exitWith{ false;};
if(_man getVariable ["SFSM_excluded", false])exitWith{false;};
private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")exitWith{false;};
if(_action != "none")exitWith{false;};
private _launcher = secondaryWeapon _man;
if(_launcher == "")exitWith{false;};

private _launcherType = ([_launcher] call objScan_fnc_weaponData) get "description";
if(_launcherType == "AA misile launcher")exitWith{false;};
if!([_man, _launcher] call SFSM_fnc_hasAmmoForWeapon)exitWith{false;};
private _launchPos = [_man, _house] call SFSM_fnc_firePosLite;
if(isNil "_launchPos")
exitWith{
        "could not find a position to launch missile at house" call dbgmsg;
		false;
	};

[_man, "currentDestination", _launchPos] call SFSM_fnc_unitData;

true;//--------comment by papaReap----------




private _hcPresent = false;

waitUntil { ( !(isNil "PR_HC_CheckComplete") && { !(isNil "PR_HeadlessClients")  } ) };
publicVariable "PR_HC_CheckComplete";
publicVariable "PR_HeadlessClients";

if ( (count PR_HeadlessClients > 0) && { (!(isNil "PR_HC1")) } ) then {
    if (isServer) exitWith { diag_log "***soldier FSM * server exited, headless client used***"; _hcPresent = true; };
    if ( !hasInterface && {!isServer} ) exitWith { diag_log "***soldier FSM * Headless Client Loaded***"; };
} else {
    diag_log "***soldier FSM * no HC active***";
};

if (isServer && {_hcPresent}) exitWith { [] call SFSM_fnc_initSettings; };




[] call SFSM_fnc_initSettings;
[] call SFSM_fnc_postConfig;



{[_x] call SFSM_fnc_InitMan} 	forEach allUnits;
{[_x] call SFSM_fnc_InitGroup} 	forEach allGroups;
{[_x] call SFSM_fnc_initVehicle}forEach vehicles;
{_x   call SFSM_fnc_curatorEH}  forEach allCurators;


[] spawn SFSM_fnc_TaskManager;
[] call  SFSM_fnc_unitKilled; 
[] call SFSM_fnc_unitCreated;

addMissionEventHandler ["BuildingChanged", {
	params ["_from", "_to", "_isRuin"];
    ["Building changed!", 2] call dbgmsg;

}];




diag_log "***soldier FSM * server loaded***";




[] call SFSM_fnc_logSettings;// This file contains settings and global variables that I do not want the end-user to touch.

missionNamespace setVariable ["SFSM_Battles",         createHashmap, true];
missionNamespace setVariable ["SFSM_debugMarkers",    [],            true];
missionNamespace setVariable ["SFSM_TaskCycleTimer",  10, 	         true];
missionNamespace setVariable ["SFSM_TestMode", 		  false, 	     true];
missionNamespace setVariable ["SFSM_customEH_Timer",  0.2, 	         true];


//variables used in the sound reaction / bulletImpact functions
SFSM_lastShotFired     = -300;
SFSM_lastSoundCheck    = -300;
SFSM_lastImpactHandler = -300;
SFSM_lastCrater        = -300;

//How often the battlefield-data is updated
SFSM_BattleUpdateSec = 10;

//types of trees, simple way of distinguishing between hard and soft cover
SFSM_treeTypes = [
					"t_ficusb1s_f",
					"b_ficusc1s_f",
					"t_pinuss1s_f",
					"t_pinuss2s_b_f",
					"t_pinuss2s_f",
					"t_phoenixc1s_f",
					"b_ficusc2s_f",
					"b_neriumo2s_f",
					"t_populusn3s_f",
					"b_neriumo2s_white_f",
					"t_phoenixc3s_f",
					"t_ficusb2s_f",
					"t_oleae1s_f"
				];

//used when a "light areaScan is needed"
SFSM_lightScanTypes=[
					"BUSH",
					"HOUSE",
					"ROCK",
					"ROCKS",
					"RUIN",
					"SMALL TREE",
					"TREE",
					"WALL"
				];
SFSM_excludedMapObjs = [
    'cargo_addon01_v1_f',
    "setbig", 
    "setsmall", 
    "neriumo2d", 
    "chair", 
    "fence",
    "rowboat",
    "arundod",
    "cages",
    "bench",
    "dangerbend",
    "canisterplastic",
    "lamp",
    "sign",
    "gate",
    "sunshade",
    "basket",
    "swing",
    "water",
    "campingtable",
    "pavement",
    "coil",
    "pallet",
    "crates",
    "roof",
    "feed",
    "atm_0",
    "sacks_heap_f",
    "kiosk_papers_f",
    "pole",
    "goal",
    "calvary",
    "tbox",
    "bucket",
    "slide",
    "garbage_line_f",
    "bluntstones_erosion",
    "vergepost_f",
    "ficusc2d",
    "slums01_8m",
    "slums01_pole",
    "campingchair",
    "tableplastic",
    "garbagebin_01"
];

SFSM_explosives = [
  "SatchelCharge_Remote_Mag",
  "IEDUrbanBig_Remote_Mag",
  "IEDLandSmall_Remote_Mag",
  "DemoCharge_Remote_Mag",
  "ClaymoreDirectionalMine_Remote_Mag",
  "IEDLandBig_Remote_Mag",
  "IEDUrbanSmall_Remote_Mag"
];

SFSM_hijackVehicleTypes = [
  "car (AA-AT combo launcher)",
	"MRAP (HMG)",
	"car (HMG)",
	"MRAP (GMG)",
	"car (GMG)",
	"car (Rocket launcher)",
	"BTR"];

//deactivate group-reset on vehicle FSM
if(!isNil "DCOnoGroupReset")
then{
		missionNamespace setVariable ["DCOnoGroupReset", true, true];
		"DCO soldier FSM deactivated group-reset for DCO vehicle FSM" call dbgmsg;
	};

//logic-side is causing issues, setting it as friendly to all.
{
	_x setFriend [sideLogic, 1];
	sideLogic setFriend [_x, 1];

} forEach [east, west, independent];params ["_vehicle"];
[_vehicle] call SFSM_fnc_vehicleFiredEh;
if([_vehicle]call Tcore_fnc_deadCrew)exitWith{};

private _vehicleData = createHashMap;
_vehicleData set 	["currentBattle", "none"];
_vehicleData set 	["hiddenPos", []];

_vehicle setVariable ["SFSM_vehicleData", _vehicleData, true];

_vehicleData;if(is3DEN)exitWith{};

if((!isNil "SFSM_disableSoldierFSM")
&&{SFSM_disableSoldierFSM})
exitWith{
			["SOLDIER FSM Has been disabeled!!", true, true, 2, "--SFSM ShutDown--"] 
			call Tcore_fnc_debugMessage;
		};

//for ease of writing I have shortened the name of the debugMessage function.
if(isNil "dbgmsg")
then{dbgmsg = SFSM_fnc_debugMessage};


if(isNil "SFSM_Version")then{missionNamespace setVariable ["SFSM_Version", 0.44, true]};


if ( (isServer) || {( !hasInterface && { !isServer } )} ) then {
    //if (isNil "PR_Allow_HC") then { PR_Allow_HC = false; publicVariable "PR_Allow_HC"; };



    [] spawn SFSM_fnc_serverInit;
}; // PapaReap to let hc pass



//if(isServer)	then{[] spawn SFSM_fnc_serverInit};
if(hasInterface)then{[] spawn SFSM_fnc_initClient};



if(isNil 'ObjScan_Fnc_average')
then{
		private _noScanText = "DCO unitScanner not detected, Soldier FSM will not function properly.";
		[_noScanText] remoteExecCall ["hint", 0];
		diag_log _noScanText;
	};//Set default settings unless previously defined
if(isNil "SFSM_allowFlinching")
then{
		SFSM_disableSoldierFSM  = false; // disable soldier FSM
		SFSM_Debugger			= true;  // show debug-info, and 3D markers
		SFSM_allowFlinching     = true;  // Units will flinch on incoming fire.
		SFSM_allowDodging       = true;  // Units will dodge(change position) when incoming fire reaches the treshHold (SFSM_RpsDodgeTrigger).
		SFSM_hideFromVehicles   = true;  // Units will run away / hide from vehicles they cannot hurt.
		SFSM_AtSpecHuntVehicles = true;  // Units with launchers will target enemy vehicles instead of hiding.
        SFSM_mgSuppressClusters = true;  // MachineGunners will spray enemy positions upon initial contact
		SFSM_ExcludeZcommand    = false; // stop units that have been given waypoints by a curator from dodging
		SFSM_PlayerGrpDodge     = false; // Allows units in a group lead by a player to dodge / hide, dodging can be frustrating for players who like to micro-manage their AI
		// SFSM_FlinchTreshHold 	= 1;	 // unit will not flinch if suppression is higher than this value
		SFSM_ProneTreshHold 	= 0.8;	 // unit will stay prone if suppression is higher than this value
		SFSM_FlinchCoolDown		= 5;	 // Minimum Time between each flinch-response
		SFSM_RpsDodgeTrigger	= 4;	 // Continous Incoming bullets with no less than 1 second break, to trigger Dodging
		SFSM_DodgeCoolDown		= 10;	 // Time between each dodge-response
		SFSM_DodgeDistance		= 70;	 // How far the man will run when dodging
		SFSM_DodgeTimer			= 30;	 // max time before ending a dodge.
		SFSM_forceDodge			= true;  // Override the Vanilla FSM in order to force the unit to move when dodging
		SFSM_noCoverPanic       = true;  // unit will panic upon initiating a battle if no cover is found
		SFSM_reactFireCoolDown	= 180; 	 // Time between each returnFire-response		
		SFSM_panicCoef          = 0.5;   // chance that a man will panic upon start of engagement if he cannot see a cover-position
		SFSM_KnowledgeToFight   = 0;     // the amount of knowledge needed to start a battle between 2 units.
		SFSM_sprintSpeed        = 1.3;   // speed coef for dodging / taking cover / hiding. 1 = vanilla. 2 = twice the normal speed
		SFSM_stayCoverPosTime   = 15;    // the amount of time the soldier will stay in his position upon taking cover.
		SFSM_flinchStopDodge    = true;  // if this is toggled then the unit will stop running towards cover and instead flinch
		SFSM_emergencyRearm     = true;  // Soldiers pick up launchers from killed squad-mates, or off the ground if a vehicle is nearby
		SFSM_explosionCoverRad  = 200;   // if munition explodes within this distance from the soldier he will run for cover.
		SFSM_breakCoverOnHit    = true;  // if hit while in cover the unit will move away from current position
		//SFSM_explosionCrater    = true;  // Creates a dent in the terrain upon exploding ammo(the size varies according to ammo-type)
		SFSM_legHealingOn       = true;  // If a soldier is hit in the legs, he will inmediately go prone and heal himself, to allow for running.
		SFSM_dodgeIndoors       = false; // If a soldier is inside a house the "dodge" function will activate if the unit is taking heavy fire.
		
		SFSM_CQBdistance        = 100;   // Distance to enemy inside a building needed to activate CQB-mode.
		SFSM_CQBunitCap         = 2;     // The maximum amount of units that can clear the same house at the same time. (Yip wanted 2 as a default, I recomend 4).
		SFSM_hidingTimeOut      = 30;    // The max amount of time a unit will stay in a hiding-pos before returning to normal. (hiding is triggered by the presence of a enemy vehicle)
		SFSM_hearingHide        = true;  // Hide by hearing vehicle: A Vehicle with engine ON is detected within hearing-distance
		SFSM_hearingDistance    = 250;   // Max distance a vehicle will be reacted to by hearing, (if in a urban area, half of this distance is used).
		SFSM_overrunDistance    = 50;    // If an enemy comes within this range while holding cover / hiding the unit will try to evade the enemy, set to 0 to deactivate.

		SFSM_houseDemolition    = true;  // Allow units with explosives in their backpack to blow up houses instead of clearing them room by room.
		SFSM_hijackVehicles     = true;  //
		SFSM_rpgHouse           = true;  //
        // #include "\soldierFSM\Functions\PR\initSettings.sqf"//DEACTIVATED FOR
};


//Make sure settings are available globally.

missionNamespace setVariable ["SFSM_FlinchTreshHold",	1, 	                    true];
missionNamespace setVariable ["SFSM_ProneTreshHold", 	SFSM_ProneTreshHold, 	true];
missionNamespace setVariable ["SFSM_FlinchCoolDown", 	SFSM_FlinchCoolDown, 	true];
missionNamespace setVariable ["SFSM_RpsDodgeTrigger", 	SFSM_RpsDodgeTrigger, 	true];
missionNamespace setVariable ["SFSM_DodgeCoolDown", 	SFSM_DodgeCoolDown, 	true];
missionNamespace setVariable ["SFSM_DodgeDistance", 	SFSM_DodgeDistance, 	true];
missionNamespace setVariable ["SFSM_DodgeTimer", 		SFSM_DodgeTimer, 		true];
missionNamespace setVariable ["SFSM_forceDodge", 		true, 		            true]; 
missionNamespace setVariable ["SFSM_Debugger", 			SFSM_Debugger, 			true]; 
missionNamespace setVariable ["SFSM_noCoverPanic", 		SFSM_noCoverPanic, 		true];
missionNamespace setVariable ["SFSM_reactFireCoolDown", SFSM_reactFireCoolDown, true];
missionNamespace setVariable ["SFSM_ExcludeZcommand", 	SFSM_ExcludeZcommand, 	true];
missionNamespace setVariable ["SFSM_PlayerGrpDodge", 	SFSM_PlayerGrpDodge, 	true];
missionNamespace setVariable ["SFSM_hideFromVehicles", 	SFSM_hideFromVehicles, 	true];
missionNamespace setVariable ["SFSM_AtSpecHuntVehicles",SFSM_AtSpecHuntVehicles,true];
missionNamespace setVariable ["SFSM_mgSuppressClusters",SFSM_mgSuppressClusters,true];
missionNamespace setVariable ["SFSM_disableSoldierFSM", SFSM_disableSoldierFSM, true];
missionNamespace setVariable ["SFSM_enableCustomEH",    false,    				true];//using the A3 2.10 eventhandler, this setting is here for legacy reasons
missionNamespace setVariable ["SFSM_allowFlinching",    SFSM_allowFlinching,    true];
missionNamespace setVariable ["SFSM_allowDodging",      SFSM_allowDodging,      true];
missionNamespace setVariable ["SFSM_panicCoef",         SFSM_panicCoef,         true];
missionNamespace setVariable ["SFSM_KnowledgeToFight",  SFSM_KnowledgeToFight,  true];
missionNamespace setVariable ["SFSM_sprintSpeed",       SFSM_sprintSpeed,       true];
missionNamespace setVariable ["SFSM_emergencyRearm",    SFSM_emergencyRearm,    true];
missionNamespace setVariable ["SFSM_explosionCoverRad", SFSM_explosionCoverRad, true];
missionNamespace setVariable ["SFSM_breakCoverOnHit",   SFSM_breakCoverOnHit,   true];
// missionNamespace setVariable ["SFSM_explosionCrater",   SFSM_explosionCrater,   true];
missionNamespace setVariable ["SFSM_legHealingOn",      SFSM_legHealingOn,      true];
missionNamespace setVariable ["SFSM_dodgeIndoors",      SFSM_dodgeIndoors,      true];

missionNamespace setVariable ["SFSM_CQBdistance",       SFSM_CQBdistance,       true];
missionNamespace setVariable ["SFSM_CQBunitCap",        SFSM_CQBunitCap,        true];
missionNamespace setVariable ["SFSM_hidingTimeOut",     SFSM_hidingTimeOut,     true];

missionNamespace setVariable ["SFSM_hearingHide",       SFSM_hearingHide,       true];
missionNamespace setVariable ["SFSM_hearingDistance",   SFSM_hearingDistance,   true];
missionNamespace setVariable ["SFSM_overrunDistance",   SFSM_overrunDistance,   true];

missionNamespace setVariable ["SFSM_hijackVehicles",    SFSM_hijackVehicles,    true];
missionNamespace setVariable ["SFSM_rpgHouse",          SFSM_rpgHouse,          true];


true;params["_man"];
private _data = _man getVariable "SFSM_UnitData";
if(!isNil "_data")exitWith{};
// if!([_man] call SFSM_fnc_isRealMan)exitWith{};

// if(isPlayer _man)exitwith{};
if([(group _man)] call Tcore_fnc_nilNull)exitWith{};

private _unitData = createHashMap;

// Setting all time variables to -300 to allow for 
// proper reactions from the start of the game  

_unitData set 	["Last_Hit", 	        -300];
_unitData set 	["Last_Close_Bullet", 	-300]; 
_unitData set 	["last_bullet_fired", 	-300];
_unitData set 	["flinchTimer", 		-300];
_unitData set 	["dodgeTimer", 			-300];
_unitData set 	["reactFireTimer",		-300];
_unitData set 	["lastBattle",		    -300];
_unitData set   ["last_time_in_cover",  -300];
_unitData set 	["roundsPrSecond", 		0];
_unitData set 	["action", 				"none"];
_unitData set 	["currentBattle",		"none"];
_unitData set 	["currentBuilding",     "none"];
_unitData set 	["targetBuilding",      "none"];
_unitData set 	["currentDestination",	[0,0,0]];
_unitData set 	["hashValue", 			hashvalue _man];
_unitData set 	["current suppression", (getSuppression _man)];
_unitData set   ['pathEnabeled',        (_man checkAIFeature "PATH")];
_unitData set 	["hunkObjectHash", 	    []];
_man setVariable["SFSM_UnitData", 		_unitData, true];

if(_man getVariable ["SFSM_Excluded",false])exitWith{};

[_man] call SFSM_fnc_SuppressedEH;
[_man] call SFSM_fnc_firedEH;
[_man] call SFSM_fnc_hitEH;

_man addEventHandler ["Deleted", {
		private _building = _unitData get "currentBuilding";
		if!(_building == "none")
		then{missionNamespace setVariable [_building, nil, true];};
		diag_log "Soldier FSM ==> unit deleted";
	}];



true;params["_group"];
private _data = _group getVariable "SFSM_groupData";

if(!isNil "_data") exitWith {_data};
if!((side _group) in [east, west, independent])exitWith{};
if(_group getVariable ["SFSM_Excluded",false])exitWith{};

private _groupData = createHashmap;
_groupData set ["currentBattle",	"none"];
_groupData set ["lastSpotting",	    -300];
_groupData set ["dodgeDisabeled",   false];
_groupData set ["dodgeDisableTime", time];

_group setVariable["SFSM_groupData", _groupData, true];
_group setVariable["SFSM_lastKnownEnemy", objNull, true];

_group setVariable["SFSM_ZeusWaypoints", [], true];



if!(SFSM_enableCustomEH)
then{[_group] call SFSM_fnc_enemyDetected};

waitUntil { !isNil "SFSM_overrunDistance" };

[] call SFSM_fnc_3dDebug;
diag_log "**soldier FSM client loaded**";

if!(isServer)
then{[] call SFSM_fnc_logSettings};

true;params["_objectHash", "_enemyPositions"];
private _objectShape    = _objectHash get "3dData";
private _pos 			= _objectShape get "position";
private _avgEnemyRelDir = [_enemyPositions, _pos] call Tcore_fnc_avgRelDir;
private _safeDir 		= _avgEnemyRelDir;
private _rigthDir       = [(_safeDir -90)] call Tcore_fnc_formatDir;
private _leftDir        = [(_safeDir +90)] call Tcore_fnc_formatDir;
private _objMaxSize     = (selectMax [(_objectShape get "length"), (_objectShape get "width")]);

private _sfPos = [_pos # 0, _pos # 1, _safeDir, (_objMaxSize + 0.8)] call Tcore_fnc_sinCosPos;
private _fireLeft = [_sfPos # 0, _sfPos # 1, _leftDir, (_objMaxSize + 0.3)] call Tcore_fnc_sinCosPos;
private _fireRight = [_sfPos # 0, _sfPos # 1, _rigthDir, (_objMaxSize + 0.3)] call Tcore_fnc_sinCosPos;

_objectHash set ["safe_pos", _sfPos];
_objectHash set ["fireLeft", _fireLeft];
_objectHash set ["fireRight", _fireRight];

_objectHash;params ["_man"];

sleep (random 15);

if(!alive _man)exitWith{};



private _weapon = ([(primaryWeapon _man)] call BIS_fnc_itemType)#1;
private _launcher = ([(secondaryWeapon _man)] call BIS_fnc_itemType)#1;
private _machineGunner = _weapon == "MachineGun";
private _medic         = "Medikit" 	in (items _man);
private _misileGuy     = _launcher == "MissileLauncher";
private _hunkerDown = (random 1 > 0.7
					or _machineGunner
					or _medic
					or _misileGuy);

if(_hunkerDown)exitWith{[_man] call SFSM_fnc_initHunker};

_man doFollow leader(group _man);params["_man", "_pos", "_battleField"];
private _timer = time + 60;

[_man, "action", "move to hunker pos"] 	call SFSM_fnc_unitData;

private _script = [_man, _pos, 20] spawn SFSM_fnc_forceMoveToPos;
waitUntil{scriptDone _script};
private _distToPos = (eyePos _man) distance2d _pos;
if(_distToPos > 1)
then{
	 while {_distToPos > 1} do {

		_script = [_man, _pos, 3] spawn SFSM_fnc_forceMoveToPos; 
		waitUntil{scriptDone _script};

		_distToPos = (eyePos _man) distance2d _pos;

		private _text = ["move to hunker pos ", _distToPos, "m left"] joinString "";

		[_man, "action", _text] 	call SFSM_fnc_unitData;


		if(!alive _man)exitWith{};
		if(time>_timer)exitWith{};
		if(isNil "_battleField")exitWith{};
		
		sleep 3;
	 };
};
true;params ["_objData"];
private _objectShape = _objData get "3dData";
private _type        = (_objData get "type");
private _height      = (_objectShape get "top")#2;
private _xAndY       = [(_objectShape get "length"), (_objectShape get "width")];
private _XYratio     = (_objectShape get "Y to X");
private _maxSize     = (selectMax _xAndY);
private _minSize     = (selectMin _xAndY);

private _canCover    = _height > 0.35;
private _squareish   = _XYratio > 0.69 && {_XYratio < 1.4};
private _mediumSize  = _maxSize < 4 && {_minSize >= 0.7 && {_height < 4}};
private _notbush     = !(_type in SFSM_treeTypes);
private _notExcluded = !(_type in SFSM_excludedMapObjs);


private _isHunkerObject = (
							_squareish 
							&& {_canCover 
							&& {_mediumSize 
							&& {_notbush
							&& {_notExcluded}}}}
						  );

_isHunkerObjectparams ["_man", "_battlefield", "_objectHash"];

if(isNil "_man")exitWith{};
if(isNull _man)exitWith{};

private _side           = side _man;
private _lastName      = ((name _man) splitString " ")#1;
private _enemyPositions = [_side, _battlefield] call SFSM_fnc_getEnemyPositions;

if(isNil "_lastName")then{_lastName = hashValue _man};
if(isNil "_lastName")exitWith{};

[_objectHash, _enemyPositions] call SFSM_fnc_setHobjPositions;
private _safePos = _objectHash get"safe_pos";
if(_safePos distance2D _man > 100)exitWith{};

_objectHash set ["owner", _lastName];
doStop _man;

private _script = [_man, _safePos] spawn SFSM_fnc_moveToHunkerPos;
waitUntil{sleep 1; scriptDone _script};

if((eyePos _man) distance2d _safePos > 2)
exitWith{[_man, "action", "cannot reach hunker pos"] call SFSM_fnc_unitData};

[_man, "action", "hunker down"] 	call SFSM_fnc_unitData;
[_man, "hunkObjectHash", _objectHash] call SFSM_fnc_unitData;

_man disableAI "PATH";
_man setUnitPos "DOWN";

true;params ["_man"];
private _battlefield = [_man] call SFSM_fnc_getBattlefield;
if(isNil "_battlefield")exitWith{false;};
private _action = [_man, "action"] call SFSM_fnc_unitData;
if("hunker" in _action)exitWith{false;};


if((leader (group _man) == _man)
&&{count(units (group _man)) > 1})exitWith{false;};

private _maxDistance    = (_battlefield get "radius")*2;
private _knownEnemies   = [_man, _maxDistance, 'enemies'] call Tcore_Fnc_nearKnownEnemies;
if(count _knownEnemies == 0)exitWith{false;};

private _hunkerObject = [_man, _battlefield] call SFSM_fnc_getHunkerObject;
if(isNull _hunkerObject)exitWith{false;};

private _objData = [_hunkerObject, _battlefield]   call SFSM_fnc_hunkObjHash;
if(isNil "_objData")exitWith{false;};

private _enemyVehicles = [];
private _vehicles = missionNamespace getVariable (_battlefield get "vehicles");
_enemyVehicles = _vehicles select 
		               {((side _x) != (side _man))
		               &&{(!([(side _x), (side _man)] call BIS_fnc_sideIsFriendly))
					   &&{!([_x] call Tcore_fnc_deadCrew)}}};


if(count _enemyVehicles > 0)
exitWith{false;};

[_man, _battlefield, _objData] spawn SFSM_fnc_hunkerFSM;

true;params["_object", "_battlefield"];
Private _mapObjects    = missionNamespace getVariable (_battlefield get "mapObjects");
Private _hunkerObjData = _mapObjects get "hunkerObjData";
private _pos = ASLToAGL (getPosASL _object);
private _key = str _pos;
private _data = _hunkerObjData get _key;

_dataparams[
	"_man", 
	"_objectHash", 
	"_enemyPositions"
	];

if(isNil "_objectHash")exitWith{};

if(isNil "_safePos")exitWith{};


private _safePos    = _objectHash get "safe_pos";
private _statusData = _objectHash get "status";
private _objShape   = _objectHash get "3dData";
private _objPos     = (_objShape get "top");
		_objPos     = [_objPos, 0.4] call Tcore_fnc_AddZ;
if(_objPos#2 < 1.5)
then{_objPos = [_objPos, 0.5] call Tcore_fnc_AddZ};

private _canShoot    = [_objPos, _enemyPositions, _man] call Tcore_fnc_visibleFromPositions;
private _verySafe    = !([(ASLToAGL aimPos _man), _enemyPositions, _man] call Tcore_fnc_visibleFromPositions);
private _needHealing = ((getDammage _man) > 0.25);
private _safe        =  (_man distance2d _safePos) <= 0.6;

_statusData set ["canShoot",     _canShoot];
_statusData set ["needHeal",     _needHealing];
_statusData set ["safe",         _verySafe];

params ["_man", "_battlefield", "_objectHash"];

private _script = [_man, _battlefield, _objectHash] spawn SFSM_fnc_initHunkerFSM;
waitUntil{sleep 0.5; scriptDone _script};

private _action = [_man, "action"] call SFSM_fnc_unitData;

if(_action == "cannot reach hunker pos")
exitWith{
			sleep 1.5;
			[_man, _objectHash, _action] call SFSM_fnc_endHunker;
		};


private _side = side _man;
private _timer = time + 120;
private _endText = "";


while {true} do {

	if(_timer < time)exitWith{_endText = "timed out"};
	if(!alive _man)exitWith{_endText = "died"};
	if(isNil "_battlefield")exitWith{_endText = "battle ended"};

	_enemyPositions = [_side, _battlefield] call SFSM_fnc_getEnemyPositions;

	if(isNil "_enemyPositions")exitWith{_endText = "no enemy positions"};
	if(count _enemyPositions < 1)exitWith{_endText = "no enemy positions"};

	[_objectHash, _enemyPositions] call SFSM_fnc_setHobjPositions;
	[_man, _objectHash, _enemyPositions] call SFSM_fnc_hunkerFsmStatus;

	_script = [_man, _objectHash, _battlefield] spawn SFSM_fnc_handleHunkerStatus;
	waitUntil{sleep 0.5; scriptDone _script};

	private _action = ([_man, "action"] call SFSM_fnc_unitData);
	private _noTarget = _action == "wait, cannot aquire target from hunker-pos";
	private _status = (_action splitString " ")#0;
	
	
	if('hiding' in _action)exitWith{_endText = "hiding from vehicle"};
	if(_status == "end")exitWith{_endText = "no enemies"};

	if(_status == "displace,")exitWith{_endText = "displacing"};

	if(_status == "fired!")then{_timer = _timer + 15};

	private _safePos = _objectHash get "safe_pos";
	_man doMove _safePos;

	private _randomSleep = round(random 15);
	sleep _randomSleep;

	if(_status == "wait," 
	&&{! _noTarget})then{_timer = _timer + _randomSleep};

	if(_noTarget)then{_timer = _timer - 10};
};

if(_endText == "displacing")
exitWith{
			sleep 1;
			[_man, _objectHash, _endText] call SFSM_fnc_endHunker;
			sleep 1;
			private _canDisplace = [_man] call SFSM_fnc_initHunker;
			sleep 1;
			if(_canDisplace)
			then{[_man, "action", "Displacing to new hunkerPos"] call SFSM_fnc_unitData};
		};

[_man, _objectHash, _endText] call SFSM_fnc_endHunker;
params["_hObject", "_hunkerObjData"];
private _pos       = (ASLToAGL (getPosASLVisual _hObject));
private _objKey    = str _pos;
private _available = ((_hunkerObjData get _objKey) get "owner") == "none";
_availableparams ["_man",  "_objectHash", "_battlefield"];
private _action 	= + [_man, "action"] call SFSM_fnc_unitData;
private _lastIn 	= + [_man, "Last_Close_Bullet"] call SFSM_fnc_unitData;
private _statusData = _objectHash get "status";
private _canShoot   = _statusData get "canShoot";
private _needHeal   = _statusData get "needHeal";
private _canHeal    = [_man] call SFSM_fnc_canSelfHeal;
private _maxDistance = (_battlefield get "radius")*2;



if(_canHeal
&&{_needHeal})
then{	
		[_man, _action] spawn SFSM_fnc_proneHeal;
		private _timer = time + 20;
		waitUntil {
					sleep 1; 
					if(([_man, "action"] call SFSM_fnc_unitData) == _action)exitWith{true};
					if(time > _timer)exitWith{true};
					false;
					};
	};

If!(_canShoot)exitWith{[_man, "action", "displace from hunker-pos, cannot reach enemy"] call SFSM_fnc_unitData};

if(time - _lastIn < 3)exitWith{[_man, "action", "wait and hunker down, just recieved fire"] call SFSM_fnc_unitData};

private _enemies = [_man, _maxDistance, 'enemies']call Tcore_fnc_nearKnownEnemies;
If(count _enemies < 1)exitWith{[_man, "action", "end hunkering, no enemies"] call SFSM_fnc_unitData};

private _nearest      = [_man, _enemies] call Tcore_fnc_nearestPos;
if(typeName _nearest == "SCALAR")exitWith{[_man, "action", "end hunkering, no enemies"] call SFSM_fnc_unitData};


private _nearDistance = _man distance2D _nearest;
if(_nearDistance <= 70)exitWith{[_man, "action", "displace, enemy close to hunker-pos"] call SFSM_fnc_unitData};

private _target = [_man, _enemies, true] call Tcore_fnc_getLosTarget;
if(isNull _target)exitWith{[_man, "action", "wait, cannot aquire target from hunker-pos"] call SFSM_fnc_unitData};

[_man, "action", "fire at target from hunker-pos"] call SFSM_fnc_unitData;

private _timer = time + 3;
_man setUnitPos "UP";
waitUntil {sleep 1; ((stance _man) ==  "STAND") or (time > _timer)};
sleep 1;
_man doSuppressiveFire _target;
sleep 1;
waitUntil {sleep 0.5; !(currentCommand _man == "Suppress")};

_enemies = [_man, _maxDistance, 'enemies']call Tcore_fnc_nearKnownEnemies;
_target  = [_man, _enemies, true] call Tcore_fnc_getLosTarget;
if!(isNull _target)
then{
		for "_i" from 1 to 10 do
		{
			_enemies = [_man, _maxDistance, 'enemies']call Tcore_fnc_nearKnownEnemies;
			_target  = [_man, _enemies, true] call Tcore_fnc_getLosTarget;

			if(alive _target)
			then{_man doFire _target; sleep 0.3};

		};
		sleep 2;
	};



_man setUnitPos "DOWN";

sleep 2;

if((damage _man) > 0.25)then{_man action ["HealSoldierSelf", _man]};

[_man, "action", "fired! Now hunker down"] call SFSM_fnc_unitData;params["_man", "_battlefield"];
private _side = side _man;
Private _mapObjects    = missionNamespace getVariable (_battlefield get "mapObjects");
Private _hunkerObjData = _mapObjects get "hunkerObjData";
private _hnkObjects    = missionNamespace getVariable (_battlefield get "hunkerObjects");

if(isNil "_hnkObjects")exitWith{"no hunker objects yet, loading data" call sfsm_fnc_debugmessage; objNull};

private _nearObjects     = _hnkObjects inAreaArray [(getPos _man), SFSM_DodgeDistance, SFSM_DodgeDistance];
private _approvedObjects = [_side, _battlefield, _hunkerObjData, _hnkObjects] call SFSM_fnc_filterHunkerObjects;
_approvedObjects = _approvedObjects select {_x in _nearObjects};
private _objCount        = count _approvedObjects;
if(_objCount == 0)exitWith{"no hunker objects found" call sfsm_fnc_debugmessage; objNull};


private _nearest = [_man, _approvedObjects] call Tcore_fnc_nearestPos;

_nearest;params["_hnkObjects", "_hunkerObjData"];
private _object = "";
{
	if([_x, _hunkerObjData] call SFSM_fnc_hunkAvailable)
	exitWith{_object = _x};

} forEach _hnkObjects;

if(_object == "")exitWith{};

_objectparams ["_side", "_battlefield", "_hunkerObjData", "_hnkObjects"];

private _enemyPositions = [_side, _battlefield] call SFSM_fnc_getEnemyPositions;

if(count _enemyPositions < 1)exitWith{[]};
if(count _hnkObjects < 1)exitWith{[]};

private _approvedKeys   = [];
private _counter = 0;
{
			private _object = _hnkObjects # _counter;
			private _shape  = _y get "3dData";
			private _topPos = (_shape get "top");
			_topPos         = [_topPos#0, _topPos#1, (_topPos#2 + 0.5)];
			private _visible = [_topPos, _enemyPositions] call Tcore_fnc_visibleFromPositions;

			if(_visible
			&&{(_y get "owner") == "none"})
			then{
					private _key    = _x;
					_approvedKeys pushBack _key;
					_y set ["available", true];	
				}
			else{_y set ["available", false]};

			_counter = _counter + 1;
} forEach _hunkerObjData;


private _approvedObjects   = [];

{
	private _pos = (ASLToAGL (getPosASLVisual _x));
	private _key = str _pos;

	if(_key in _approvedKeys)
	then{_approvedObjects pushBackUnique _x};

} forEach _hnkObjects;

_approvedObjectsparams ["_man", "_objectHash", "_reason"];

[_man, "action",         "none"] 	call SFSM_fnc_unitData;
[_man, "hunkObjectHash", []] call SFSM_fnc_unitData;
_man enableAI "PATH";
_man setUnitPos "AUTO";
_man doFollow leader(group _man);

if((!isNil "_objectHash")
&&{(typeName _objectHash == "HASHMAP")})
then{_objectHash set ["owner", "none"]};


[["Hunker FSM ended for: ", (name _man), " ", _reason]] call SFSM_fnc_debugMessage;params["_hunkerObjData", "_objData"];
private _status = createHashmap;
// private _safePos = (_objData get "3dData") get "back";

_status set ["canShoot",     true];
_status set ["needHeal",     false];
_status set ["safe",         true];
					
private _hnkObjDt = + _objData;
_hnkObjDt set ["owner", "none"];
_hnkObjDt set ["available", false];
_hnkObjdt set ["status", _status];
// _hnkObjdt set ["safePos",_safePos];

_hunkerObjData set [_position, _hnkObjDt];

true;private _actionText = "none";
params["_man", "_actionText"];
private _timer = time + 3;
private _standAnim 	= "AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon";
private _crouchAnim	= "AmovPknlMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon";

[_man, "action", "emergency heal"] call SFSM_fnc_unitData;
[_man, _actionText] call SFSM_fnc_endHealEH;

switch (stance _man) do
	{
		case "STAND" :	{_man playMove _standAnim };
		case "CROUCH": 	{_man playMove _crouchAnim};
	};

waitUntil{
			sleep 0.1;
			((stance _man) == "prone"
			or !alive _man
			or time > _timer)
		};

_man action ["HealSoldierSelf", _man];private _actionText = "none";
params ["_man", "_eh", "_actionText"];
private _damage  = damage _man;
private _timeOut = time + 10;
waitUntil { damage _man != _damage or time > _timeOut };
[_man, "action", _actionText] call SFSM_fnc_unitData;

if!("hunker" in _actionText)then{_man setUnitPos "AUTO"};

_man removeEventHandler ["HandleHeal", _eh];params ["_man"];
if(_man getVariable ["SFSM_Excluded",false])exitWith{false};

private _hasMedkit = ("FirstAidKit" in (items _man) 
					 or "Medikit" 	in (items _man));

(_hasMedkit && {SFSM_legHealingOn})params ["_man"];
private _minReactionTime = 0.1;
private _reactionTime	 = 1;
private _timeReduction 	 = random(_man skill "spotTime");

_reactionTime = _reactionTime - _timeReduction;

if	(_reactionTime < _minReactionTime)
then{_reactionTime = _minReactionTime};

[_man, _reactionTime] spawn SFSM_fnc_execStandardFlinch;

_reactionTime;params["_man"];
private _sideStances = [
	"aadjppnemstpsraswrfldleft",
	"aadjppnemwlksraswrfldleft_f",
	"aadjppnemstpsraswrfldright",
	"aadjppnemwlksraswrfldright_f", 
	"aadjppnemstpsraswrflddown_amovppnemstpsraswrfldnon"
];
// _man setUnitPos "AUTO";
if(animationState _man in _sideStances
&& {stance _man == "PRONE"})
then{_man playMoveNow "amovppnemstpsraswrfldnon"};
params ["_man", "_bigProjectile", "_shooter"];
private _flinchFnc    = SFSM_fnc_standardFlinch;

//store coolDowntimer, and set flinching value.
[_man, "flinchTimer", (time + SFSM_FlinchCoolDown)] call SFSM_fnc_unitData;
[_man, "flinching", true] 							call SFSM_fnc_unitData;
[_man, "action", "reacting"] 						call SFSM_fnc_unitData;

if(_bigProjectile)then{_flinchFnc = SFSM_fnc_BigBulletFlinch};

private _reactionTime = [_man] 	call _flinchFnc;
[_man, _reactionTime, _shooter] spawn SFSM_fnc_endFlinch;

true;params ['_man', '_reactionTime'];
sleep _reactionTime;

[_man, "action", "flinch"] call SFSM_fnc_unitData;

switch (stance _man) do
	{
		case "STAND" :	{ _man setUnitPos "MIDDLE" };
		case "CROUCH": 	{ _man setUnitPos "DOWN"  };
		case "PRONE" : 	{ [_man] spawn SFSM_fnc_Roll;};
	};params ["_man", '_reactionTime', "_shooter"];
private _actionTime = 1.2;
private _sideStances = [
	"aadjppnemstpsraswrfldleft",
	"aadjppnemwlksraswrfldleft_f",
	"aadjppnemstpsraswrfldright",
	"aadjppnemwlksraswrfldright_f", 
	"aadjppnemstpsraswrflddown_amovppnemstpsraswrfldnon"];

if(!isNil '_reactionTime')
then{_actionTime = _actionTime + _reactionTime};
	
	sleep _actionTime;
	[_man, "flinching", false] 	call SFSM_fnc_unitData;
	[_man, "action", "none"] 	call SFSM_fnc_unitData;

if ((stance _man) == "PRONE"
&&{(animationState _man) in _sideStances})
then{
		_man playMove "AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon";
	};
sleep 1;
if(isNil "_man")exitWith{};

//spamming the normalStance, because for some reason the playMove is being a biatch
[_man] call SFSM_fnc_normalizeStance;

sleep 2;
if(isNil "_man")exitWith{};

// force the anim back if the previous attempts failed.
if ((animationState _man) in _sideStances)
then{_man switchMove "amovppnemstpsraswrfldnon"};

private _canReactFire = [_man] call SFSM_fnc_canReactFire;

if(_canReactFire)then{[_man, _shooter] spawn SFSM_fnc_reactFire};params ["_man"];

if!(SFSM_allowFlinching)exitWith{false}; 
if(_man getVariable ["SFSM_Excluded",false])exitWith{false};


private _flinchTimer 	= [_man, "flinchTimer"] 		call SFSM_fnc_unitData;
private _action 	 	= [_man, "action"] 	 		    call SFSM_fnc_unitData;
private _stopDodge      = (SFSM_flinchStopDodge && {"dodging" in _action 
                        && {(!("CQB" in _action))
                        &&{!("building" in _action)}}});
private _available      = _action == 'none'
                        or _stopDodge;

//stopDodge needs love
if(_stopDodge)
then{"stopping dodge" call dbgmsg};

private _canFlinch  = (_flinchTimer < time && {_available});


_canFlinch;params ["_man", "_launchPos", "_shooter"];
if([_man] call Tcore_fnc_isPlayer)exitWith{};

private _timer     = time + 5;
private _canFlinch = [_man] call SFSM_fnc_canFlinch;

if(_canFlinch)	
then{
		[_man, true, _shooter] call SFSM_fnc_flinch;
		waitUntil{sleep 0.25; [_man, _timer] call SFSM_fnc_manAvailable};
		[_man] call SFSM_fnc_normalizeStance;
	};

[_man, _launchPos] call SFSM_fnc_eventTriggeredCover;params ["_man"];

[_man, "action", "flinch"] call SFSM_fnc_unitData;

private _move 		= "";
private _standmoves = [	"AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDright",
						"AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft",
						"AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon"
						];

private _kneelMoves = [	"AmovPknlMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft",
						"AmovPknlMstpSrasWrflDnon_AadjPpneMstpSrasWrflDright"];

private _proneMoves = [	//"AmovPpneMstpSrasWrflDnon_AadjPpneMstpSrasWrflDdown",
						"AmovPpneMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft",
						"AmovPpneMstpSrasWrflDnon_AadjPpneMstpSrasWrflDRight"
						];

switch (stance _man) do {
	case "STAND": 	{_move = selectRandom _standmoves};
	case "CROUCH": 	{_move = selectRandom _kneelMoves};
	case "PRONE": 	{_move = selectRandom _proneMoves};
}; 

_man playMove _move; 

0;private _action = "placing explosive";
params["_man", "_action"];
private _explosive = [_man] call SFSM_fnc_getChargeFromBackPack;
if(_explosive isEqualTo [])exitWith{};

[_man, "action", _action] call SFSM_fnc_unitData;
_man playMoveNow "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
[_man] call SFSM_fnc_putAnimDoneEH;
// waitUntil{
// 	// [_man, "action"] call SFSM_fnc_unitData == "none";
// 	   private _animDone = _unit getVariable ["SFSM_animDone", false];
// 	   _animDone;
// 	};
sleep 1;
// the name of the inventory item is different from
// the CFG_name used to create the explosive.
// So: _charge = cfg_name, _explosive = inventoryName.

private _charge = _explosive#1;
_explosive = _explosive#0;
private _explosivePos = _man modelToWorld [0,0.3,0];
_charge = createMine [_charge, _explosivePos, [], 0];
_man addOwnedMine _charge;
_man removeItemFromBackpack _explosive;

true;params[
		"_man", 
		"_building",
		"_buildingVarName"
	];


[_man, "targetBuilding", _buildingVarName] call SFSM_fnc_unitData;
_building setVariable ["SFSM_explosiveRigged", true];
missionNamespace setVariable [_buildingVarName, _building];
_man setBehaviour "AWARE";
_man setCombatBehaviour "AWARE";
_man setUnitPos "UP";
_man setAnimSpeedCoef SFSM_sprintSpeed;
_man setSpeedMode "FULL";params["_man"];
private _explosives = [_man] call SFSM_fnc_carriedExplosives;
if(count _explosives <1)exitWith{[]};
_explosives sort false;
private _explosive = _explosives#0;
private _charge = [_explosive] call SFSM_fnc_formatExplosiveName;

[_explosive, _charge];params["_invName"];
private _length = count _invName;
private _cfgName = _invName select [0,(_length - 10)];
_cfgName = _cfgName insert [(count _cfgName), "F"];
_cfgName;params["_man"];
private _carriedExplosives = [];
{
	if(_x in SFSM_explosives)
	exitWith{_carriedExplosives pushback _x};
	
} forEach backpackItems _man;


_carriedExplosives;params["_man", "_building"];
if!(SFSM_houseDemolition)exitWith{false;};
if(!alive _man) exitWith {false;};
if([_man] call SFSM_fnc_getChargeFromBackPack isEqualTo []) exitWith {false;};
if(((getPosATL _building)#3)<0)exitWith{false;};

//Random coef based on the courage of the unit.
private _braveEnough = (_man skill "courage")>=(random 1);
if!(_braveEnough)exitWith{"no demo, no courage" call dbgmsg; false;};

true;params[
		"_man", 
		"_building"
	];

//init function variables
private _startPos = getPos _man;
private _startDistance = (_building distance2D _startPos);
private _bPos = (getPos _building);
private _escapeDir = _building getDir _startPos;
private _escapePos = [_bPos#0, _bPos#1, _escapeDir, 100] call Tcore_fnc_sinCosPos;
private _timer = time +30;
private _buildingVarName = ["Occupied building ", (name _man), (getPos _building)] joinString "_";
private _path = [_building, true, _startPos] call SFSM_fnc_buildingPath;
private _startSpeedMode = speedMode _man;
[_man, _building, _buildingVarName] call SFSM_fnc_initHouseDemolition;
[_man, "action", "CQB: moving to place explosives"] call SFSM_fnc_unitData;

//move into house.
{
	

	private _moveIn = [
		_man, //unit 
		_x,   //position 
		4,    //timeout (optional)
		3,    //minimum distance to position in order to complete move. (optional)
        2     // sleep between each repetition of doMove. (optional)
		] spawn SFSM_fnc_forceMoveToPos;

    waitUntil{sleep 1; scriptDone _moveIn;};
    
	private _distance = (_man distance2D _building);
	private _currentBuilding = [_man]call SFSM_fnc_currentBuilding;
	private _arrived = ((!isNil "_currentBuilding") &&{_currentBuilding == _building});
    
	//conditions for ending "move-in loop"
	if((_arrived)
	|| (!alive _man)
	|| (time > _timer
	|| ((_distance > _startDistance)
	&& {_distance > SFSM_dodgeDistance})))
	exitWith{};
	
} forEach _path;

//check status 
private _currentBuilding = [_man]call SFSM_fnc_currentBuilding;
private _arrived = ((!isNil "_currentBuilding") && {_currentBuilding == _building});
private _success = (alive _man && {_arrived});

//if man is dead or not inside the house.
if!(_success)
exitWith{
	      [_man, "action", "Demolition failed!"] call SFSM_fnc_unitData;
		  sleep 2;
		  [_man, _buildingVarname] call SFSM_fnc_endCQBclearing;
		  _building setVariable ["SFSM_explosiveRigged", false];
	};


//place explosive
private _placeExplosive = [_man, "Placing explosives"] spawn SFSM_fnc_placeExplosive;
waitUntil{(scriptDone _placeExplosive || time > _timer)};


//Get out!
[_man, "action", "explosives placed. RUN!"] call SFSM_fnc_unitData;
private _script = [_man, _escapePos, 30, 60] spawn SFSM_fnc_clearCQBPos;
waitUntil{
	sleep 1; 
	(scriptDone _script);
	};



//if man is dead
if(!alive _man)exitWith{
	"man died before detonating explosives" call dbgmsg;
	[_man, _buildingVarname] call SFSM_fnc_endCQBclearing;
    _building setVariable ["SFSM_explosiveRigged", false];
};

//blow it up
[_man, "action", "Detonating explosives"] call SFSM_fnc_unitData;
sleep 1;
_man action ["TouchOff", _man];
sleep 1;
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, _startSpeedMode] call SFSM_fnc_endCQBclearing;
_building setVariable ["SFSM_explosiveRigged", false];

true;params ["_vehicle"];
_vehicle addEventHandler ["Fired", {
	params [
				"_unit", 
				"_weapon", 
				"_muzzle", 
				"_mode", 
				"_ammo", 
				"_magazine", 
				"_projectile", 
				"_gunner"
			];
	
	[_unit] 							 call SFSM_fnc_soundReaction;
	[_projectile, _ammo, _unit, _gunner] call SFSM_fnc_projectileEH;
	

	


	SFSM_lastShotFired = time; 
	true;
}];addMissionEventHandler ["EntityKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	private _unitData = _unit getVariable "SFSM_UnitData";
	if(isNil "_unitData")    exitWith{};
	if!([_unit] call SFSM_fnc_isRealMan)exitWith{};

	_unit setVariable ['SFSM_killTime', time];

	private _building = _unitData get "currentBuilding";
	if!(_building == "none")
	then{missionNamespace setVariable [_building, nil, true];};

	private _battleKey = _unitData get "currentBattle";
	if(_battleKey == "none")exitWith{};

	[_unit] spawn SFSM_fnc_AddWeaponsToBattlefield;

	//add the deceased to the battlefield-hashmap.
	private _battleField = SFSM_Battles get _battleKey;
	missionNamespace getVariable (_battleField get "deadMen") pushBack _unit;
	
	
	private _asset = [_unit] call SFSM_fnc_squadAsset;
	if!(_asset == "AT-specialist")exitWith{};

	//if it is a at-specialist then get someone else to pick up the launcher.
	private _group = (group _unit);
	private _groupUnits = units _group;
	private _unitCount = count _groupUnits;

	if(_unitCount == 0)exitWith{};

	private _nearest = [_unit, _groupUnits] call Tcore_Fnc_nearestPos;
	
	if(typeName _nearest == "SCALAR")exitWith{};
	if(!alive _nearest)              exitWith{};
	if!((vehicle _nearest) isKindOf "man")exitWith{};

	private _launcher = secondaryWeapon _nearest;
	if!(_launcher == "")exitWith{};

	[_nearest]
	spawn{
			params ["_nearest"];
			sleep 3;
			[_nearest] spawn SFSM_fnc_emergencyRearm;
		};
	
}];addMissionEventHandler ["EntityCreated", {
	params ["_entity"];
	if([_entity] call Tcore_fnc_nilNull)exitWith{};
	if([_entity] call Tcore_fnc_isPlayer)exitWith{};

	if!(_entity isKindOf "man")
	exitwith{
		if (_entity isKindOf "land"
		|| _entity isKindOf "air") 
		then {[_vehicle] call SFSM_fnc_initVehicle;};
	};
	
	if!([_entity] call SFSM_fnc_isRealMan)exitWith{};

	[_entity] call SFSM_fnc_initMan;
	"Unit spawned in" call dbgmsg;
}];

addMissionEventHandler ["GroupCreated", {
	params ["_group"];
	[_group] call SFSM_fnc_initGroup;
	"Group spawned in" call dbgmsg;
}];

addMissionEventHandler ["GroupDeleted", {
	params ["_group"];
	"Group deleted" call dbgmsg;
}];*
Supressed params documentation.

* unit: Object - Unit to which the event is assigned
* distance: Number - Distance of the projectile pass-by
* shooter: Object - Who (or what) fired - vehicle or drone
* instigator: Object - Who pressed the trigger. Instigator is different from the shooter when player is operator of UAV for example
* ammoObject: Object - The ammunition itself
* ammoClassName: String - The ammunition's classname
* ammoConfig: Config - The ammunition's CfgAmmo config path

*/

Params ["_man"];
if!([_man] call SFSM_fnc_isRealMan)exitWith{};

private _unitData = (_man getVariable "SFSM_UnitData");

//exit on all unwanted object-types (_man);
if(isNil "_unitData")exitWith{[_man] call SFSM_fnc_InitMan};
if([(group _man)] call Tcore_fnc_nilNull)exitWith{};
if([_man] call Tcore_fnc_nilNull)exitWith{};
if([_man] call Tcore_fnc_isPlayer)exitWith{};

//overWrite previous EH.
if("SuppressedEH" in _unitData) then{_man removeEventHandler ["Suppressed", (_unitData get "SuppressedEH")]};
if("explosionEH" in _unitData) then{_man removeEventHandler ["Explosion", (_unitData get "SuppressedEH")]};

private _SuppressedEH =
_man addEventHandler ["Suppressed", {
	params ["_unit", "_distance", "_shooter", "_instigator", "_ammoObject", "_ammoClassName", "_ammoConfig"];
	if (!alive _unit)exitWith{};
	if((!(SFSM_TestMode)) 
	&&{(side _man == side _shooter)})exitwith{};

	[_unit, _ammoClassName, _shooter] call SFSM_fnc_onSuppression;
	
}];

private _explosionEH = 
_man addEventHandler ["Explosion", {
	params ["_vehicle", "_damage", "_source"];
	
	if([_man] call SFSM_fnc_canFlinch)
	then{
			[_vehicle, true] call SFSM_fnc_flinch;
	};

}];

[_man, "SuppressedEH", _SuppressedEH] call SFSM_fnc_unitData;
[_man, "explosionEH", _explosionEH] call SFSM_fnc_unitData;




if(SFSM_TestMode)
then{
		
		_man removeAllEventHandlers "FiredNear";
		_man addEventHandler ["FiredNear", {
			params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
			if(SFSM_TestMode)then{[_unit, _ammo, _firer] call SFSM_fnc_onSuppression};

		}];
};

true;waitUntil {time > 2};

if!(SFSM_enableCustomEH)
exitWith{"custom eventhandler deactivated, using vanilla enemy-detected EH" call dbgmsg};

while {true} do {
sleep SFSM_customEH_Timer;
	{
		private _leader = leader _x;
		private _enemy = ([_leader, _x] call SFSM_fnc_enemySpotted);

		if(!isNull _enemy)
		then{
				private _startBattle = [_leader, _enemy] call SFSM_fnc_canSpotInitBattle;
				if!(_startBattle)exitWith{};
				"Enemy spotted, starting battle" call dbgmsg;
				[_leader, _enemy] call SFSM_fnc_InitBattlefield;
			};
	} forEach allGroups;
};
params["_man"];
_man addEventHandler ["AnimDone", {
	params ["_unit", "_anim"];
	if("AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon" == _anim)
	then{
		// [_unit, "action", "none"] call SFSM_fnc_unitData;
		_unit setVariable ["SFSM_animDone", true];
		_unit removeEventHandler [_thisEvent, _thisEventHandler];
	};
}];params[
		"_projectile",  
		"_ammoType", 
		"_shooter", //the object that fired the projectile
		"_gunner"   //If the projectile was fired from a vehicle, then _gunner would be the one pulling the trigger
	];

//see: "references/ammoClassDescription.sqf"
//for more info on the ammo classes.

private _launchPos   = getPos _shooter;
private _ammoData    = [_ammoType] call objScan_fnc_getAmmoData;
private _class       = _ammoData get "class ID";
private _handGrenade = "Grenade" in (typeOf _projectile);
private _explosive   = _class > 2.5 && (! (_class in [9.1, 9.2, 9.4]));
private _bullet      = _class > 1 && _class < 3;


if((_handGrenade
|| _explosive))
exitWith{
            [_projectile, _launchPos, _shooter, _ammoType] call SFSM_fnc_explosionEH;
            if(_handGrenade)then{[_projectile, _shooter] spawn SFSM_fnc_handleGrenade;};
		};

if(_bullet)
exitwith{
			[_projectile, _launchPos, _shooter] call SFSM_fnc_bulletEH;
		};



true;params["_man"];
_man addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];

	if([_unit] call Tcore_fnc_nilNull)exitWith{};
	if([_unit] call Tcore_fnc_isPlayer)exitWith{};
	
	//used in the stayInCover function
	[_unit, "Last_Hit", time] call SFSM_fnc_unitData;
	_unit setVariable ["SFSM_enemy", _source];

	//check conditions before initiating healing
	private _action = [_unit, "action"] call SFSM_fnc_unitData;
	if("hunker" in _action)exitWith{};

	
	if(_action == "Holding cover position")
	exitWith{//Stop holding if the man is in a cover-pos
				[_unit, (getPos _unit), true] call SFSM_fnc_endStayInCover; 
				"end cover, hit by bullet" call dbgmsg;
			};

	if!([_unit] call SFSM_fnc_canSelfHeal)exitWith{};
	
	private _legDamage = getAllHitPointsDamage _unit # 2 # 10;
	
	if(_legDamage > 0.4)
	then{[_unit] spawn SFSM_fnc_proneHeal};
			
		
}];private _versionName = ["soldier FSM V. ", SFSM_Version] joinString "";
		private _bigTxt = "<t size='1.7'>";
		private _medTxt = "<t size='1.2'>";
		private _smallTxt = "<t size='0.75'>";
		private _outLine  = "<t shadow='2'>";
		private _red      = "<t color='#f72222'>";
		private _khaki    = "<t color='#acffa4'>";
		private _green    = "<t color='#83ff7f'>";
		private _end      = "</t>";
		private _nLine    = "<br/>";
		private _warningText = parseText
		([
			_outLine, _bigTxt, _red, "!!Warning!!", _end,_end,_nLine,
			_khaki,"You just loaded the game. It has been reported by some users that",
			"DCO soldier fsm will sometimes cause the game to crash in ",
			_red,_medTxt, " single player",_end,_end," when saving and ",_red,_medTxt,"loading",_end,_end,
			" the game",_red,_medTxt," 2 or more",_end,_end," times.",_end,_nLine,
			_nLine,
			_green,"If you want the technical explanation contact us via discord or steam",_end,_nLine,
			_nLine,
			_end,_nLine,_smallTxt, _versionName, _end,
			_end

		] joinString "");

_warningText;addMissionEventHandler ["Loaded", {
	params ["_saveType"];
	[] spawn {
		if(!isMultiplayer)then{
			sleep 20;
			private _text= [] call SFSM_fnc_gameLoadedWarning;
			hint _text;
		};
	};
}];params ["_man"];

_man addEventHandler ["Fired", {
	params [
				"_unit", 
				"_weapon", 
				"_muzzle", 
				"_mode", 
				"_ammo", 
				"_magazine", 
				"_projectile", 
				"_gunner"
			];
	
	[_unit] 							 call SFSM_fnc_triggerBattleOnShot;
	[_unit, _muzzle, _weapon] 			 call SFSM_fnc_multiplyReactionFire;
	[_unit] 							 call SFSM_fnc_soundReaction;
	[_unit, "last_bullet_fired", time] 	 call SFSM_fnc_unitData;
	[_projectile, _ammo, _unit, _gunner] call SFSM_fnc_projectileEH;
	
	SFSM_lastShotFired = time;
    
	true;
}];params ["_projectile", "_launchPos", "_shooter", "_ammoType"];

_projectile setVariable ["launchPos", _launchPos];
_projectile setVariable ["shooter", _shooter];
_projectile setVariable ["ammoType", _ammoType];

_projectile addEventHandler ["Explode", {
	params ["_projectile", "_pos", "_velocity"];
	_projectile removeEventHandler [_thisEvent, _thisEventHandler];
	private _launchPos = _projectile getVariable "launchPos";
	private _shooter = _projectile getVariable "shooter";
	private _ammoType = _projectile getVariable "ammoType";
	
	[_launchPos, _pos, _shooter, _ammoType] spawn SFSM_fnc_handleExplosion;
	
}];params ["_leader", "_group"];
if!((side _group) in [east, west, independent])exitWith{objNull};


private _battle       = [_group, "currentBattle"] call SFSM_fnc_groupData;
private _lastSpotting = [_group, "lastSpotting"]  call SFSM_fnc_groupData;

if(isNil "_battle")			 exitWith{objNull};
if!(_battle == "none")		 exitWith{objNull};
if(time - _lastSpotting < 30)exitWith{objNull};
if(!alive _leader)			 exitWith{objNull};

private _currentEnemy   = _leader findNearestEnemy _leader;
private _knowledge      = _leader knowsAbout _currentEnemy;
private _lastKnownEnemy = _group getVariable "SFSM_lastKnownEnemy";


_group setVariable["lastKnownEnemy", _currentEnemy];

if(isNull _currentEnemy)				  exitWith{objNull};
if!(_group knowsAbout _currentEnemy > 0)  exitWith{objNull}; 
if!(_currentEnemy isKindOf "land")		  exitWith{objNull};
if((count crew _currentEnemy)<1)		  exitWith{objNull};
if(_currentEnemy == _lastKnownEnemy)	  exitWith{objNull};
if(_currentEnemy distance2D _leader > 600)exitWith{objNull};
if(_knowledge < SFSM_KnowledgeToFight)    exitWith{objNull};

 [_group, "lastSpotting", time] call SFSM_fnc_groupData;

"Enemy spotted" call dbgmsg; 

_currentEnemy;params ["_group"];

_group addEventHandler ["EnemyDetected", {
	params ["_group", "_newTarget"];
	if(side _group == sideLogic)exitWith{};
	private _leader 	= leader _group;
	private _knowledge  = _leader knowsAbout _newTarget;
	private _knowsAboutEnemy = _knowledge > SFSM_KnowledgeToFight;
	private _canInitBattle = [_leader, _newTarget] call SFSM_fnc_canSpotInitBattle;

	if!(_knowsAboutEnemy)exitWith{};
	if!([_leader] call SFSM_fnc_isRealMan)exitWith{};
	if!([_newTarget] call SFSM_fnc_isRealMan)exitWith{};
	if!(_canInitBattle)exitWith{};
	
	[_leader, _newTarget] call SFSM_fnc_InitBattlefield;
	"Enemy spotted, starting battle" call dbgmsg;

	true;
}];

true;private _actionText = "none";
params ["_man", "_actionText"];

_man addEventHandler ["HandleHeal", {
	params ["_unit", "_healer", "_isMedic"];
	[_unit, _thisEventHandler, _actionText] spawn SFSM_fnc_endSelfHeal; 
}];
_this addEventHandler ["CuratorObjectSelectionChanged", 
{
	params ["_curator", "_entity"];
	if(SFSM_Debugger
	&&{_entity isKindOf "man"
	&&{alive _entity}})
	then{
			[_entity] call SFSM_fnc_manInfo;
			SFSM_currentCurObj = _entity;
		};
}];

_this addEventHandler ["CuratorWaypointPlaced", {
	params ["_curator", "_group", "_waypointID"];
	if!(SFSM_ExcludeZcommand)exitWith{};
	_this call SFSM_fnc_zWPplaced;
}];

_this addEventHandler ["CuratorWaypointDeleted", {
	params ["_curator", "_waypoint"];
	if!(SFSM_ExcludeZcommand)exitWith{};
	_this call SFSM_fnc_zWPdeleted;
}];

_this addEventHandler ["CuratorObjectDeleted", {
	params ["_curator", "_entity"];
	private _unitData = _entity getVariable "SFSM_UnitData";
	if(isNil "_unitData")exitWith{};
	if!(_entity isKindOf "man")exitWith{};

	"Unit was deleted by curator" call dbgmsg;

	private _currentBattle = [_entity, "currentBattle"] call SFSM_fnc_unitData;
	if(_currentBattle == "none")exitWith{};
	[] call SFSM_fnc_deleteWarning;
	
}];params ["_projectile", "_launchPos", "_Shooter"];

_projectile setVariable ["launchPos", _launchPos];

_projectile addEventHandler ["Deflected", {
	params ["_projectile", "_pos", "_velocity", "_hitObject"];
	private _launchPos = _projectile getVariable "launchPos";
	
	_projectile removeAllEventHandlers "Deflected";
	_projectile removeAllEventHandlers "Deleted";

	[_launchPos, _pos] call SFSM_fnc_handleBulletImpact;
}];

_projectile addEventHandler ["Deleted", {
	params ["_entity"];
	private _launchPos = _entity getVariable "launchPos";
	private _pos = getPosASLVisual _entity;
	
	_projectile removeAllEventHandlers "Deflected";
	_projectile removeAllEventHandlers "Deleted";

	[_launchPos, _pos] call SFSM_fnc_handleBulletImpact;
}];params["_group"];

if(isNil "_group") exitWith{"Nil group" call dbgmsg; false};
if(isNull  _group) exitWith{"Null group, cannot dodge" call dbgmsg; false};

private _grpDodgeDisabeled = [_group, 'dodgeDisabeled'] call SFSM_fnc_groupData;

if(!isNIl "_grpDodgeDisabeled" 
&&{_grpDodgeDisabeled})
exitWith{"zeus blocked dodge" call dbgmsg; false}; 

private _leader = (leader _group);

private _playerLead = [_leader] call Tcore_fnc_isPlayer;

if(_playerLead && {(! SFSM_PlayerGrpDodge)})
exitWith{
			"player-lead group, cannot dodge" call dbgmsg; 
			false
		}; 

true; private _distance = SFSM_DodgeDistance;
params['_man', '_enemy', '_distance'];
private _pos = getPos _man;
private _dir = _man getRelDir _enemy;
private _dirCorrection = selectRandom[90, -90];

_dir = [(_dir + _dirCorrection)] call Tcore_fnc_formatDir;

private _latPos = [_pos#0, _pos#1, _dir, _distance] call Tcore_fnc_sinCosPos;

_latPosprivate _dodgeDir = selectRandom ["right", "left"]; 
params ["_man", "_enemy", "_dodgeDir"];
private _XX 			= (getPos _man) # 0;
private _YY 			= (getPos _man) # 1;
private _dir 			= _man getRelDir _enemy;
private _dirCorrection	= -90;

if(_dodgeDir == "right")then{_dirCorrection = 90};

private _newDir 	= (_dir + _dirCorrection);
private _dodgePos 	= [_XX, _YY, _newDir, SFSM_DodgeDistance] call SFSM_fnc_sinCosPos;


_dodgePosparams ["_man", "_endPos"];
private _dodgeFromPos   = _endPos;
private _enemyPositions = [_man, 500, "positions"] call Tcore_fnc_nearKnownEnemies;

if(count _enemyPositions > 0)
then{
		private _newPos = [_man, _enemyPositions] call Tcore_fnc_nearestPos;
		if(typeName _newPos == "SCALAR")exitWith{}; //the nearestPos function returns a number when nothing is found
		_dodgeFromPos = _newPos;
	};


[_man, _dodgeFromPos, false] call SFSM_fnc_Dodge;

true;params ["_man", "_endPos", "_timer", "_target", "_behaviour"];

waitUntil{sleep 0.5; [_man, _endPos, _timer] call SFSM_fnc_dodgeEnded}; 


if(SFSM_forceDodge)
then{
	
	_man enableAI "TARGET";
	_man enableAI "AUTOCOMBAT";
	_man enableAI "AUTOTARGET";
	
	_man doTarget _target;
	
	_man setUnitPos "AUTO";
};

_man setAnimSpeedCoef 1;
[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;

//if the dodge was ended by a flinch then exit the script before setting action = "none"
//and init hunker
private _action = [_man, "action"] call SFSM_fnc_unitData;
if(_action in ["reacting", "flinch"])exitWith{};


_man doMove (getPos _man);

[_man, "action", 	"none"]	call SFSM_fnc_unitData;


[_man] spawn SFSM_fnc_randomHunkerInit;

true;params ["_man", "_endPos", "_timer"];

if(isNil "_endPos")	exitWith{true};
if(isNil "_man")	exitWith{true};
if(!alive _man)		exitWith{true};
if(time > _timer)	exitWith{true};
if((_man distance2D _endPos) < (2))exitWith{true};

private _action = [_man, "action"] call SFSM_fnc_unitData;

if(_action in ["reacting", "flinch"])
exitWith{true};


falseprivate _seekCover = true;
params ["_man", "_enemy", "_seekCover"];

//I would normally prefer putting this codeBlock in the "canDodge" function,
//But since "unitInDoor" is using the "lineIntersectsSurfaces" command I have to put it here
//for performance reasons.
if(_man call SFSM_fnc_unitInDoor 
&&{(! SFSM_dodgeIndoors)})
exitWith{"indoor dodge blocked" call dbgmsg};

private _dodgeToHouse = false;
//random chance to init CQB cover (50%)
if(random 1 > 0.5)
then{
	  private _house = [(getPos _man), SFSM_DodgeDistance] call SFSM_fnc_nearestAvailableHouse;
	  if (isNil '_house') exitWith {};
	  private _coverPos = [_man, _house, true] call SFSM_fnc_moveIntoHouseInit;
	  if!(_coverPos isEqualTo [0,0,0])
	  then{_dodgeToHouse = true};
};

if(_dodgeToHouse)exitWith{};


private _coolDown = (time + SFSM_DodgeCoolDown);
[_man, "dodgeTimer", _coolDown] call SFSM_fnc_unitData;
[_man, "dodging", 	 true] 		call SFSM_fnc_unitData;


private _target		 = getAttackTarget _man;
private _behaviour   = behaviour _man;
private _timer 		 = time + SFSM_DodgeTimer;
private _dodgePos 	 = [_man, _enemy] call SFSM_fnc_GetDodgePos;
private _action      = "dodging";

private _coverRadius = SFSM_DodgeDistance / 2;
private _coverLatPos = [_man, _enemy, _coverRadius] call SFSM_fnc_getLateralPos;
private _coverPos    = [_man, _coverLatPos, _coverRadius, false] call SFSM_fnc_getCoverPos;
private _coverFound  = (!isNil "_coverPos" && {typeName _coverPos == 'ARRAY'});
private _group       = group _man;

if(_coverFound
&&{_seekCover})
then{
		_dodgePos = _coverPos;
		_action   = "dodging to cover";
	};





if(SFSM_forceDodge)
then{
	_man disableAI "TARGET";
	_man disableAI "AUTOCOMBAT";
	_man disableAI "AUTOTARGET";

	_man doTarget objNull;

if(stance _man == "prone")then{_man setUnitPos "MIDDLE"};
};

[_man, "currentDestination", _dodgePos] call SFSM_fnc_unitData;
[_man, "action", _action]	call SFSM_fnc_unitData;

_man setAnimSpeedCoef SFSM_sprintSpeed;
_group setSpeedMode 'FULL';
_man doMove _dodgePos;

[_man, _dodgePos, _timer, _target, _behaviour] spawn SFSM_fnc_EndDodge;
true;private _noRpsParam = false;
params ["_man", "_noRpsParam"];
if!(SFSM_allowDodging)exitWith{false};
if(_man getVariable ["SFSM_Excluded",false])exitWith{false};

private _group             = group _man;
private _grpCanDodge       = [_group] call SFSM_fnc_groupCanDodge;
private _dodgeTimer 	   = [_man, "dodgeTimer"] 		call SFSM_fnc_unitData;
private _action 	 	   = [_man, "action"] 	 		call SFSM_fnc_unitData;
private _pathEnabeled 	   = [_man, 'pathEnabeled'] 	call SFSM_fnc_unitData;
private _rps			   = [_man, "roundsPrSecond"] 	call SFSM_fnc_unitData;
private _coolDownEnded     = _dodgeTimer < time;
private _lowSuppression	   = getSuppression _man < SFSM_ProneTreshHold;
private _highRPS		   = (_rps > SFSM_RpsDodgeTrigger) || _noRpsParam;

private _canDodge = (_coolDownEnded
					&&{(_action == 'none')
					&&{_lowSuppression
					&&{_highRPS
					&&{_grpCanDodge
					&&{_pathEnabeled}}}}});

_canDodge;private _color = [0.6,0.6,0.1,1];
private _text = "";
private _icon  = "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa";
private _size  = 1;
private _maxDistance = 200;
params ["_posArr", "_color", "_text", "_icon", "_size", "_maxDistance"];
{
	[_x, _color, _text, _icon] call SFSM_fnc_drawObjectMarker;
	
} forEach _posArr;params["_man"];
private _data        = ([_man] call objScan_fnc_infGearData);
private _weaponData  = _data get "weaponData";
private _description = _data get "description";
private _weapon      = (_weaponData get "primary") get "description";
private _launcher    = secondaryWeapon _man;
private _versionName = ["soldier FSM V. ", SFSM_Version] joinString "";
private _name        = (name _man);
private _rank        = toLowerANSI(rank _man);
private _role        = [_man] call SFSM_fnc_squadAsset;

private _outLine     = "<t shadow='2'>";
private _smallTxt    = "<t size='0.75'>";
private _bigTxt      = "<t size='1.4'>";
private _aqua        = "<t color='#00ffff'>";
private _khaki       = "<t color='#acffa4'>";
private _green       = "<t color='#83ff7f'>";
private _red         = "<t color='#e32e2e'>";
private _end         = "</t>";


if!(_launcher == "")
then{
		private _hasAtAmmo = [_man, (secondaryWeapon _man)] call SFSM_fnc_hasAmmoForWeapon;
		_launcher          = (_weaponData get "secondary") get "description";
		_launcher          = [_launcher, " <br/>"] joinString "";
		if(_hasAtAmmo)then{_launcher = [_launcher,_aqua," Has launcher ammo <br/>", _end] joinString "";}
		              else{_launcher = [_launcher,_red, " No launcher ammo <br/>", _end] joinString "";};
	};


			
private _text = parseText([

							                      _outLine, _bigTxt,_aqua, 
							_rank, " ", _name,    _end, _end, "<br/>",  _green,
							_description,         "<br/>", "<br/>", 
							_weapon,              "<br/>",
							_launcher,            "<br/>",
							_role,                "<br/>", "<br/>",_end,  _smallTxt, 
							_versionName,         _end, _end

				]joinString "");
			
hint _text;

true;private _camPos = (positionCameraToWorld [0,0,0]);
private _men    = _camPos nearEntities  ["CAManBase", 200];
//
{
	private _notPlayer 	= !(isPlayer _x);
	if(_notPlayer
	&&{(_x Getvariable ["bis_fnc_moduleRemoteControl_owner", ""]) isEqualTo ""})
	then{[_x] call SFSM_fnc_3DdebugText};
} forEach _men;private _smallTxt = "<t size='0.75'>";
private _versionName = ["soldier FSM V. ", SFSM_Version] joinString "";
private _signature = ["--> ", _versionName, " setting: "] joinString "";
private _outLine  = "<t shadow='2'>";
private _aqua     = "<t color='#00ffff'>";
private _khaki    = "<t color='#acffa4'>";
private _green    = "<t color='#83ff7f'>";
private _end      = "</t>";

private _hintText = parseText
(
	[
		_outLine,

		_aqua,
		"Debugger ",  SFSM_Debugger, "<br/>",
		"Hiding ",    SFSM_hideFromVehicles, "<br/>",
		"prone-treshHold ",     SFSM_ProneTreshHold,  "<br/>",
		"react-fire coolDown ", SFSM_reactFireCoolDown, "<br/>","<br/>",
		_end,

		_khaki,
		"Hunt Vehicles ",         SFSM_AtSpecHuntVehicles, "<br/>",
		"MG suppress clusters  ", SFSM_mgSuppressClusters, "<br/>",
		"Custom EH ",             SFSM_enableCustomEH, "<br/>","<br/>",
		_end,

		_green,
		"Flinching ",              SFSM_allowFlinching, "<br/>",
		"flinchCoolDown ",         SFSM_FlinchCoolDown, "<br/>",
		"flinchTreshHold ",        SFSM_FlinchTreshHold, "<br/>","<br/>",
		_end,

		_aqua,
		"Dodging ",             SFSM_allowDodging,    "<br/>",
		"Player group dodge  ", SFSM_PlayerGrpDodge,  "<br/>",
		"Exclude Zeus commanded units ", SFSM_ExcludeZcommand, "<br/>",
		"dodge-CoolDown ",      SFSM_DodgeCoolDown, "<br/>",
		"cover distance ",      SFSM_DodgeDistance, "<br/>",
		"dodge-timer ",         SFSM_DodgeTimer, "<br/>",
		"dodge Trigger ",       SFSM_RpsDodgeTrigger, "<br/>",
		"Sprint speed ",         SFSM_sprintSpeed, "<br/>",
		"force-dodge ",         SFSM_forceDodge, "<br/>","<br/>",
		_end,

		_green,
		"explosion Cover Radius ",SFSM_explosionCoverRad, "<br/>",
		"break Cover when Hit ",SFSM_breakCoverOnHit, "<br/>",
		"panic-coef ",          SFSM_panicCoef, "<br/>",
		"no-Cover-Panic ",      SFSM_noCoverPanic, "<br/>",
		"emergency Rearm ",     SFSM_emergencyRearm, "<br/>",
		"Knowledge needed for battle ", SFSM_KnowledgeToFight,"<br/>","<br/>",
		_end,

		_smallTxt, _versionName, _end,

		_end
 	] joinString ""
);

if(SFSM_Debugger)
then{hint _hintText};
diag_log parseText("*************************************************************************");

diag_log ([_signature, "Debugger ",                     SFSM_Debugger]           joinString "");
diag_log ([_signature, "Flinching ",                    SFSM_allowFlinching]     joinString "");
diag_log ([_signature, "Dodging ",                      SFSM_allowDodging]       joinString "");

diag_log parseText("-------------------------------------------------------------------------");

diag_log ([_signature, "Hiding ",                       SFSM_hideFromVehicles]   joinString "");
diag_log ([_signature, "Hunt Vehicles ",                SFSM_AtSpecHuntVehicles] joinString "");
diag_log ([_signature, "MG suppress clusters ",         SFSM_mgSuppressClusters] joinString "");

diag_log ([_signature, "Custom EH ",                    SFSM_enableCustomEH]    joinString "");
diag_log ([_signature, "Exclude Zeus commanded units ", SFSM_ExcludeZcommand]   joinString "");
diag_log ([_signature, "Player group dodge ",           SFSM_PlayerGrpDodge]    joinString "");

diag_log ([_signature, "flinchTreshHold ",              SFSM_FlinchTreshHold]   joinString "");
diag_log ([_signature, "flinchCoolDown ",               SFSM_FlinchCoolDown]    joinString "");
diag_log ([_signature, "prone-treshHold ",              SFSM_ProneTreshHold]    joinString "");

diag_log parseText("-------------------------------------------------------------------------");

diag_log ([_signature, "dodge Trigger ",                SFSM_RpsDodgeTrigger]   joinString "");
diag_log ([_signature, "dodge-CoolDown ",               SFSM_DodgeCoolDown]     joinString "");
diag_log ([_signature, "dodge-distance ",               SFSM_DodgeDistance]     joinString "");

diag_log ([_signature, "dodge-timer ",                  SFSM_DodgeTimer]        joinString "");
diag_log ([_signature, "force-dodge ",                  SFSM_forceDodge]        joinString "");
diag_log ([_signature, "no-Cover-Panic ",               SFSM_noCoverPanic]      joinString "");

diag_log parseText("-------------------------------------------------------------------------");

diag_log ([_signature, "react-fire coolDown ",          SFSM_reactFireCoolDown] joinString "");
diag_log ([_signature, "panic-coef ",                   SFSM_panicCoef]         joinString "");
diag_log ([_signature, "Knowledge To Fight ",           SFSM_KnowledgeToFight]  joinString "");
diag_log ([_signature, "Sprint speed ",                 SFSM_sprintSpeed]       joinString "");
diag_log ([_signature, "emergency Rearm ",              SFSM_emergencyRearm]    joinString "");

diag_log parseText("-------------------------------------------------------------------------");

diag_log ([_signature, "explosion Cover Radius",        SFSM_explosionCoverRad] joinString "");
diag_log ([_signature, "break Cover when Hit",          SFSM_breakCoverOnHit]   joinString "");

diag_log parseText("*************************************************************************");
true;params["_battleField"];
private _hunkerObjects = missionNamespace getVariable (_battlefield get "hunkerObjects");
if(isNil "_hunkerObjects")exitWith{};

Private _mapObjects    	= missionNamespace getVariable (_battlefield get "mapObjects");
Private _hunkerObjData 	= _mapObjects get "hunkerObjData";
private _distance 		= (_battleField get "radius") * 2;

{
	private _pos   = ASLToAGL (getPosASLVisual _X);
	private _key   = str _pos;
	private _data  = _hunkerObjData get _key;
	private _owner = (_data get "owner");
	
	if!(_owner == "none")
	then{
			private _text    = _owner;
			private _icon    = "\a3\UI_F_Enoch\Data\CfgMarkers\circle1_ca.paa";
			private _color   = [0.5,0.25,0,1];
			private _status  = _data get "status";;
			
			[
				_pos,
				_color,
				_text,
				_icon,
				1.5,
				_distance
			] call SFSM_fnc_drawObjectMarker;

			[
				(_data get "safe_pos"),
				[0.3,0.7,0,1],
				"",
				"\a3\UI_F_Enoch\Data\CfgMarkers\dot1_ca.paa",
				1.5,
				_distance
			] call SFSM_fnc_drawObjectMarker;

			[
				(_data get "fireLeft"),
				[0.7,0.3,0,1],
				"",
				"\a3\UI_F_Enoch\Data\CfgMarkers\dot1_ca.paa",
				1.5,
				_distance
			] call SFSM_fnc_drawObjectMarker;

			[
				(_data get "fireRight"),
				[0.7,0.3,0,1],
				"",
				"\a3\UI_F_Enoch\Data\CfgMarkers\dot1_ca.paa",
				1.5,
				_distance
			] call SFSM_fnc_drawObjectMarker;
			
			if!(_status get "canShoot")
			then{
					private _status1Pos = [_pos, 2] call Tcore_fnc_AddZ;
					private _color = [0.9, 0.5, 0,8, 1];
					private _text = "no LOS";
					[
						_status1Pos,
						_color,
						_text,
						"",
						1.5,
						_distance
					] call SFSM_fnc_drawObjectMarker;
				};

			if(_status get "needHeal")
			then{
					private _status2Pos = [_pos, 4] call Tcore_fnc_AddZ;
					private _color = [0.9, 0.5, 0,8, 1];
					private _text = "Need healing!";
					[
						_status2Pos,
						_color,
						_text,
						"",
						1.5,
						_distance
					] call SFSM_fnc_drawObjectMarker;
				};

			if!(_status get "safe")
			then{
					private _status3Pos = [_pos, 4] call Tcore_fnc_AddZ;
					private _color = [0.9, 0.5, 0,8, 1];
					private _text = "Need to shift";
					[
						_status3Pos,
						_color,
						_text,
						"",
						1.5,
						_distance
					] call SFSM_fnc_drawObjectMarker;
				};
	};
} forEach _hunkerObjects;




	// if (_data get "available")
	// then{
	// 		_icon = selectRandom["\a3\UI_F_Enoch\Data\CfgMarkers\circle1_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\circle2_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\circle3_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\circle4_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\pencilCircle1_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\pencilCircle2_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\pencilCircle3_ca.paa"];
	// 		private _alpha = random 1;
	// 		_color =[0.43, 1, 0,8, _alpha];
	// 	}; private _color = [0.6,0.6,0.1,1];
private _text  = "";
private _icon  = "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa";
private _size  = 1; 
private _maxDistance = 500;
params["_position", "_color", "_text", "_icon", "_size", "_maxDistance"];

private _camPos   = (positionCameraToWorld [0,0,0]);
private _distance = (_camPos distance2D _position);

if(_distance < _maxDistance)
then{
		drawIcon3D 	[
					_icon,			
					_color,
					_position,	
					1, 		
					1, 		
					0, 	 		
					_text, 
					2, 			
					0.035
				];
	};

private _smallTxt = "<t size='0.75'>";
private _bigTxt   = "<t size='2'>";
private _versionName = ["soldier FSM V. ", SFSM_Version] joinString "";
private _signature = ["--> ", _versionName, " setting: "] joinString "";
private _outLine  = "<t shadow='2'>";
private _aqua     = "<t color='#00ffff'>";
private _khaki    = "<t color='#acffa4'>";
private _green    = "<t color='#83ff7f'>";
private _red      = "<t color='#e51313'>";
private _end      = "</t>";
private _newLine  = "<br/>";

private _curatorDeleted = _warningType == "curator";

private _warningText = parseText 
([
	_outLine,
	_bigTxt,_red, "!!Warning!!", _end,_end,_newLine,
	_green, "Do not delete units while they are engaged in a fight,",
	        "This might cause errors.", _end, _newLine,_newLine,
	_khaki,	"First kill them using the [end] button.", _newLine,
			"Then wait 2-5 seconds before deleting them.", _newLine,
			"This will allow the engine to properly exit the scripts.", _newLine,
			_newLine,_end,
			_smallTxt, _versionName,_end,
	_end

] joinString "");

[_warningText] remoteExec ["Hint", 0];

diag_log "DCO soldier FSM ==> Unit was deleted mid battle!"private _displayType = 1; //2 = hint, 1 = systemChat
params["_text", "_displayType"];

private _signature = ["Soldier FSM V.", SFSM_Version," -->  "] joinString "";

private _returnVal =
[_text, SFSM_Debugger, SFSM_Debugger, _displayType, _signature]
call Tcore_fnc_debugMessage;

_returnVal;private _camPos = (positionCameraToWorld [0,0,0]);
{
			private _pos       = _y get "center";
			private _radius    = _y get "radius";
			private _distance  = (_camPos distance2D _pos);
			private _inside   = _distance < (_radius * 1.5);

			private _infoPos   = [_pos#0, (_pos#1+(_radius*0.2)), 0];
			private _infoText  = _y get "currentAction";
			private _showInfo  = !(_infoText == "none");

			if(_inside)
			then{
					private _name      = ["Battlefield ", (_y get "name")] joinString "";
					private _posCount  = round(_radius / 5);
					private _positions = [_pos, _radius, _posCount] call Tcore_fnc_get360Positions;
					private _covPosHash= (_y get "coverPositions");
					private _wCovpos   = _covPosHash get "west";
					private _eCovpos   = _covPosHash get "east";
					private _gCovpos   = _covPosHash get "independent";
					private _icon      = "\A3\ui_f\data\map\markers\handdrawn\end_CA.paa";
					//private _hnkObjs   = missionNamespace getVariable (_y get "hunkerObjects");
					//private _hnkPos    = [_hnkObjs] call Tcore_fnc_posFromObjArr;
					
					[_pos, nil, _name]call SFSM_fnc_drawObjectMarker;
					[_positions] call SFSM_fnc_multiple3dmarkers;
					//[_hnkPos] call SFSM_fnc_multiple3dmarkers;
					
					if(_showInfo)then
					{[_infoPos, [0.6,0.6,1,1], _infoText]call SFSM_fnc_drawObjectMarker};
					[_y] call SFSM_fnc_hunkerObj3d;
					
				};
		} forEach SFSM_Battles;params["_action"];
private _default	= [0.5,0.6,0.4,1];


if("none" 			          == _action)	exitWith{_default};
if("reacting" 			      == _action)	exitWith{[0.3,0.3,0.8,1]};
if("! Suppressed !" 	      == _action)	exitWith{[0.9,0.1,0.1,1]};
if("Fleeing" 			      == _action)	exitWith{[0.9,0.1,0.1,1]};
if("flinch" 			      == _action)	exitWith{[0.6,0.2,0.2,1]};
if("dodging" 			      == _action)	exitWith{[0.85,0.4,0,1]};
if("Moving to fire-position"  == _action)	exitWith{[0.85,0.4,0,1]};
if("return fire" 		      == _action)	exitWith{[0.8,0.3,0.4,1]};
if("return direct fire"       == _action)   exitWith{[0.4,0.3,0.8,1]};
if("emergency heal" 	      == _action)	exitWith{[0.9,0.1,0.1,1]};
if("dodging to cover"         == _action)	exitWith{[0.5,0.25,0,1]};
if("No cover panic!"          == _action)	exitWith{[0.9,0.1,0.1,1]};
if("Picking up weapon"        == _action)	exitWith{[0.85,0.4,0,1]};

if("Get out! house is about to explode"==_action)exitWith{[0.9,0.1,0.1,1]};

if("leaving" 	        in _action)	exitWith{[0.3,0.3,1,1]};
if("success" 	        in _action)	exitWith{[0.3,0.8,0,1]};
if("taking cover" 	    in _action)	exitWith{[0.5,0.25,0,1]};
if("failed"			    in _action)	exitWith{[0.9,0.1,0.1,1]};
if("explosive"		    in _action)	exitWith{[0.85,0.4,0,1]};
if("CQB" 			    in _action)	exitWith{[0.1,0.5,0,1]};
if("Hiding"             in _action) exitWith{[0.5,0.25,0,1]};
if("Suppressing"        in _action) exitWith{[0,0,1,1]};
if("!Targeting Enemy!"  in _action)	exitWith{[0.9,0.1,0.1,1]};
if("Targeting"          in _action) exitWith{[0,0,1,1]};
if("Moving to position" in _action)	exitWith{[0.5,0.25,0,1]};



_defaultparams["_man"];
if(isPlayer _man)exitwith{};
//if man is in a vehicle
if!(typeOf (vehicle _man) == typeOf _man)exitwith{};

private _3dPos		= (ASLToAGL getPosASL _man);
private _supp		= [(getSuppression _man), 2]call ObjScan_fnc_Decimals;
private _rps		= [_man, "roundsPrSecond"] 	call SFSM_fnc_unitData;
private _action		= [_man, "action"] 			call SFSM_fnc_unitData;

private _actionTxt   = _action;
private _supTxt		 = ["Supression: ", _supp] 		joinString "";
private _incomingTxt = [_rps, " Incoming rounds"] 	joinString "";

private _suppColor 	= [_supp, 0.4, 0.4, 1];


private _actionPos 	= [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 2.3)];
private _supPos 	= [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 2.1)];
private _incPos 	= [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 1.9)];
private _excluded   = _man getVariable ['SFSM_excluded', false];
private _excludedText = ["Excluded. Error: ", _action]joinString"";
//
// if(_excluded && {isNil "_action"})then{_actionTxt = "Excluded"};
if(_excluded && {_action == "none"})then{_actionTxt = "Excluded"};
if(_excluded && {_action != "none"})then{_actionTxt = _excludedText};
if(isNil "_action")				  then{_actionTxt = "not initialized"};
if(_action == "none")			  then{_actionTxt = ""};
if(_supp > SFSM_ProneTreshHold)	  then{_actionTxt = "! Suppressed !"};
if(fleeing _man
&&{!("hunker" in  _action)
&&{_action == "none"}})	then{_actionTxt = "Fleeing"};

private _actColor	= [_actionTxt] call SFSM_fnc_actionColor;



//incoming bullets
if(_rps > 1)
then{
		drawIcon3D 	[
						"",				//texture (icon type)
						_suppColor,		//color
						_incPos,		//position
						0.2, 			//size X
						0.2, 			//size Y
						0, 	 			//angle
						_incomingTxt, 	//text
						2, 				//shadow
						0.03			//textSize
					];
	};

//suppression level

if(_supp > 0)
then{
drawIcon3D 	[
				"",			
				_suppColor,	
				_supPos,	
				0.2, 		
				0.2, 		
				0, 	 		
				_supTxt, 	
				2, 			
				0.03		
			];
};

//current action

if!(_actionTxt == "")
then{
drawIcon3D 	[
				"",			
				_actColor,	
				_actionPos,	
				0.2, 		
				0.2, 		
				0, 	 		
				_actionTxt, 
				2, 			
				0.03		
			];
};

if(_excluded)
then{

if(_action == "none")then{_actionTxt = ""}
else{_actionTxt = _action};


drawIcon3D 	[
				"\a3\ui_f\data\igui\cfg\simpletasks\letters\x_ca.paa",			
				[1,0,0,1],	
				ASLToAGL(aimPos _man),	
				0.5, 		
				0.5, 		
				0, 	 		
				_actionTxt, 
				2, 			
				0.1		
			];
};

true;if(!isnil "3DmarkersSFSM")exitWith{};
3DmarkersSFSM = true;

addMissionEventHandler ["Draw3D", {
if(SFSM_Debugger)
then{
		[] call SFSM_fnc_man3dInfo;
		[] call SFSM_fnc_battlefield3d;

}}];params ["_curator", "_group", "_waypointID"];
[_group, 'dodgeDisabeled', true] call SFSM_fnc_groupData;

(_group getVariable "SFSM_ZeusWaypoints") pushBackUnique [_group, _waypointID];

//The following code will be executed upon completing the waypoint.
private _stringCode =
[
	"private _group  = group this; ",
	"private _waypoint = [_group,",_waypointID,"]; ", 
	"private _arr = (_group getVariable 'SFSM_ZeusWaypoints'); ",
	"_arr deleteAt (_arr find _waypoint); ",
	"private _noWpLeft = ((count waypoints _group) <= 1) or (count _arr == 0);",
	"if(_noWpLeft)then",
	"{[_group, 'dodgeDisabeled', false] call SFSM_fnc_groupData; ",
	"{_arr deleteAt (_arr find _waypoint)} forEach _arr;",
	"'Last waypoint reached, group can now dodge' call SFSM_fnc_DebugMessage }; "
]
joinString '';

[_group, _waypointID] setWaypointStatements ["true", _stringCode];

true;//This eventhandler is supposed to return an array in a waypoint-format [group, waypointIndex].
//it is however only returning the group.
params ["_curator", "_waypoint"];
private _wpCount = (count(waypoints _waypoint));

if(_wpCount <= 1)
then{
		private _group = _waypoint;
		private _arr   = (_group getVariable 'SFSM_ZeusWaypoints');
		{_arr deleteAt (_arr find _waypoint)} forEach _arr;
		{[_group, 'dodgeDisabeled', false] call SFSM_fnc_groupData};
		'Last waypoint deleted, group can now dodge' call SFSM_fnc_DebugMessage;
	};

true;params["_building", "_excludedSide"];
private _shape = [_building] call Tcore_fnc_object3DShape;
private _size = selectMax [(_shape get "width"),(_shape get "length")];
private _units = (_building nearEntities ["CAManBase", _size]) select {[_x] call SFSM_fnc_isRealMan};

if(!isNil "_excludedSide")
then{_units = _units select {side _x != _excludedSide}};

_unitsparams["_man", "_building"];
private _positions = _building buildingPos -1;
private _floorPositions = [_positions] call SFSM_fnc_floorPositions;
private _nearest = ([_positions, [], {_man distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;
if(isNil "_nearest")then{_nearest = (getPos _man)};
if(count _floorPositions == 1)exitWith{_nearest};

private _manPos = getPos _man;
private _floorInUse = 0;
private _avgHeight = [_positions] call Tcore_fnc_avgHeight;

if(_manPos#2>_avgHeight)then{_floorInUse = 1;};

private _newPositions = _floorPositions#_floorInUse;
private _newNearest = ([_newPositions, [], {_man distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;

if(isNil "_newNearest")exitWith{_nearest};

_newNearest;params ['_pos', '_radius'];
private _buildings = [];
private _battleField = [_pos] call SFSM_fnc_nearestBattle;
private _filter = {(_x distance2D _pos < _radius) && {[_x] call SFSM_fnc_houseAvailable}};

//check if pos is inside a battle.
if(typeName _battleField == "HASHMAP"
&&{_battleField get "terrainLoaded"
&&{(_pos distance2D (_battleField get "center"))<(_battleField get "radius")}})
exitwith{
		  private _allBuildings = (missionNameSpace getVariable (_battleField get "buildings"));
	  	  _buildings = _allBuildings select _filter;
	  	  if(count _buildings < 1)exitwith{};
		  private _nearest = ([_buildings, [], {_pos distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;
		  _nearest;
};
 

private _allBuildings = _pos nearObjects ["house", 20];
_buildings = _allBuildings select _filter;
if(count _buildings < 1)exitwith{};
private _nearest = ([_buildings, [], {_pos distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;
_nearest;private _dodge = true; 

params['_man', '_building', '_dodge', '_enemyVehicle'];
private _path = [_building, true, (getPos _man)] call SFSM_fnc_buildingPath;
private _lastPathPos =(count _path)-1;
private _firstPathPos = _path#0;
private _hide = !isNil '_enemyVehicle';

//selects indoor positions only
private _positions = _path select SFSM_fnc_CQBcoverPosFilter;
if(_positions isEqualTo [])exitWith{[0,0,0];};

if(_hide)
then{
[_man, _building, _dodge, _firstPathPos, _positions, _enemyVehicle] spawn SFSM_fnc_moveIntoHouseExec;
}
else{
[_man, _building, _dodge, _firstPathPos, _positions] spawn SFSM_fnc_moveIntoHouseExec;
};



private _targetPos = _positions#((count _positions)-1);
[_man, "currentDestination", _targetPos] call SFSM_fnc_unitData;


_targetPos;params[
	'_man', 
	'_building', 
	'_dodge', 
	'_entrance', 
	'_positions',
	'_enemyVehicle'
	];
private _action = [_man, "action"] call SFSM_fnc_unitData;
private _WaitTimer = time + 20;
private _startTime = time;
private _hide = !isNil '_enemyVehicle';

if!(_action == 'none')
then{waitUntil{
		sleep 1; 
		([_man, "action"] call SFSM_fnc_unitData == 'none' 
		|| time > _WaitTimer)};
	};

_action = [_man, "action"] call SFSM_fnc_unitData;
if!(_action == 'none')exitWith{};

private _startSpeedMode = speedMode _man;
private _pos = _positions#((count _positions)-1);
private _completedIndoorPos = 0;
private _actionText = "dodging inside building";
private _hideInPlace = false;

if!(_dodge)
then{_actionText = "taking cover inside building"};

if(_hide)
then{
	_actionText = "hiding inside building";
	private _currentBuilding = [_man] call SFSM_fnc_currentBuilding;
	if(!isNil "_currentBuilding")then{_hideInPlace = true;};
};
// [(typeName _enemyVehicle), 2] call dbgmsg;
if(_hideInPlace)exitWith{[_man, _enemyVehicle, true] spawn SFSM_fnc_doHide;};

[_man, "action", _actionText] call SFSM_fnc_unitData;



_man setUnitPos "UP";
_man setAnimSpeedCoef SFSM_sprintSpeed;
_man setSpeedMode "FULL";


private _script = [_man,(_entrance), 60, 5] spawn SFSM_fnc_forceMoveToPos;
waitUntil{sleep 1; scriptDone _script;};

private _j = 1;
{
	
	private _baseText = "CQB: taking cover pos: ";
	if(_dodge)then{_baseText = "CQB: dodging pos: ";};
	if(_hide)then{_baseText = "CQB: hiding pos: ";};

	private _progressText = [_baseText, _j]joinString "";
	[_man, "action", _progressText] call SFSM_fnc_unitData;
	private _script = [_man, _x, 4, 2] spawn SFSM_fnc_clearCQBPos;
    waitUntil{sleep 1; scriptDone _script;};
	private _currentBuilding = [_man] call SFSM_fnc_currentBuilding;
	private _endLoop = false;
	
	if(_man distance _x <= 2
	&&{(!isNil '_currentBuilding')
	&&{_currentBuilding == _building}})
	then{
			_completedIndoorPos = _completedIndoorPos+1;
			if(_dodge)then{_endLoop = true;};
		};

	if(_completedIndoorPos >= 2)then{_endLoop = true;};
	if((_man distance2D _building) >= 100 
	&& {time - _startTime > 30})then{_endLoop = true;};

	if(_endLoop)exitwith{};
	_j=_j+1;
} forEach _positions;

private _distance = _pos distance _man;
private _moveToFinalPos = _completedIndoorPos >= 2 && {_distance > 1 && {! _dodge}};

if(_moveToFinalPos)
then{
	   private _baseText = "CQB: Moving to cover position";
	   if(_hide)then{_baseText = "CQB: Moving to hiding position ";};

	 [_man, "action", _baseText] call SFSM_fnc_unitData;
	 private _script = [_man, _pos, 30, 1.9] spawn SFSM_fnc_clearCQBPos;
     waitUntil{sleep 1; scriptDone _script;};
};

_man setUnitPos "AUTO";
_man setAnimSpeedCoef 1;
_man setSpeedMode _startSpeedMode;
[_man, "action", "Ending"] call SFSM_fnc_unitData;

if(_hide)exitWith{[_man, _dodge, _pos, _enemyVehicle] spawn SFSM_fnc_endMoveIntoHouse;};

[_man, _dodge, _pos] spawn SFSM_fnc_endMoveIntoHouse;

true;params ["_man"];
private _action = [_man, "action"] call SFSM_fnc_unitData;
private _canDodge = [_man, true] call SFSM_fnc_canDodge;
if(isNil "_action")exitWith{false;};
if(_action != "none")exitWith{false;};
if!(_canDodge)exitWith{false;};

private   _target = getAttackTarget _man;
if(!alive _target)then{_target = _man findNearestEnemy _man;};
if(!alive _target)exitWith{false;};

if(_man distance2D _target > SFSM_CQBdistance)exitWith{false;};

private _targetHouse = [_target] call SFSM_fnc_currentBuilding;
if(isNil "_targetHouse")exitWith{false;};

private _houseFull = [_man, _targetHouse] call SFSM_fnc_CQBlimitReached;
private _rigged = _targetHouse getVariable ["SFSM_explosiveRigged", false];
private _blowItUp = [_man, _targetHouse] call SFSM_fnc_canBlowUpHouse;
private _sendIt = [_man, _targetHouse] call SFSM_fnc_canRpgHouse;

if(_houseFull)exitWith{'House is already being cleared' call dbgmsg; false;};
if(_rigged)exitWith{'House is about to explode' call dbgmsg; false;};

if(_sendIt)
exitWith{
    [_man, _targetHouse] spawn SFSM_fnc_rpgHouse;
    true;
};

if(_blowItUp)
exitWith{
  [_man, _targetHouse] spawn SFSM_fnc_blowUpHouse;
  true;

};

_man doFire _target;
[_man, _targetHouse, _target] spawn SFSM_fnc_ClearBuilding;
true;params ['_building'];
private _occupants = [_building] call SFSM_fnc_unitsInBuilding;
private _positions = _building buildingPos -1;
if(count _positions < 3)exitwith{false;};
_positions = _positions select SFSM_fnc_CQBcoverPosFilter;
if(count _positions == 0)exitwith{false;};

private _available = ((count _occupants)<(count _positions));
_available;params["_buildingPositions"];
private _floors = [_buildingPositions] call SFSM_fnc_buildingFloors;
if(_floors == 1)exitWith{[_buildingPositions];};

private _avgHeight = [_buildingPositions] call Tcore_fnc_avgHeight;
private _firstFloor = _buildingPositions select {_x#2 < _avgHeight};
private _secondFloor = _buildingPositions select {_x#2 > _avgHeight};


[_firstFloor, _secondFloor];params['_man', '_dodge', '_targetPos', '_enemyVehicle'];
private _distance = _targetPos distance _man;
private _currentHouse = [_man] call SFSM_fnc_currentBuilding;
private _hide = !isNil '_enemyVehicle';
private _failed = _distance > 2.1 
                && {(! _dodge)
				&&{isNil '_currentHouse'
				&&{! _hide}}};

if(_failed)then
{
	[_man, "action", "Indoor cover failed"] call SFSM_fnc_unitData;
	_man doMove (getPos _man);
	sleep 2;
};

if(_dodge)
then{
		[_man, "action", "CQB dodge completed"] call SFSM_fnc_unitData;
		_man doMove (getPos _man);
		
		sleep 2;
	};

if((! _dodge)
&&{(! _failed)
&&{! _hide}})
then{
		_man disableAI 'path';
		[_man, "action", "holding cover indoors"] call SFSM_fnc_unitData;
		sleep SFSM_stayCoverPosTime;
		[_man, "action", "returning to normal"] call SFSM_fnc_unitData;
		sleep 2;
		_man enableAI 'path';
		_man doMove (getPos _man);
};

if(_hide)exitWith{[_man, _enemyVehicle, true] spawn SFSM_fnc_doHide;};

_man doFollow leader (group _man);
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;params["_man", "_startSpeedMode", "_building"];
private _buildingVarName = [_man, "targetBuilding"] call SFSM_fnc_unitData;
missionNamespace setVariable [_buildingVarName, nil];
[_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
[_man, "action", "none"] call SFSM_fnc_unitData;

_man doMove (getPos _man);
[_man] doFollow leader (group _man);
_man setUnitPos "AUTO";
_man setAnimSpeedCoef 1;
_man setSpeedMode _startSpeedMode;
true;params ["_man"];
private _startPos = eyepos _man;
private _endPos = getPosWorld _man vectorAdd [0, 0, 10];
private _objs = lineIntersectsWith [_startPos, _endPos, _man, objNull, true];
if(_objs isEqualTo [])exitWith{};

private _house = _objs#0;

if(count _objs == 1
&& {_house isKindOf "house"})
exitWith{_house};

{
  if(_x isKindOf "house")
  exitWith{_house = _x};
  
} forEach _objs;

if!(_house isKindOf "house")exitWith{};

_house;params ["_man", "_maxTime"];
private _action = [_man, "action"] call SFSM_fnc_unitData;
private _enemies = [_man, 8, true] call Tcore_fnc_nearSoldiers;

if(count _enemies > 0)
then{
      _enemies = _enemies select {
                                  (([_man, _x] call SFSM_fnc_targetVisible)
                                  &&
                                  {!([(side _man), (side _x)] call BIS_fnc_sideIsFriendly)});
                                 };
};


if(count _enemies > 0)
then{
         private _killTimer = time + (_maxTime / 2);
         [_man, "action", "CQB: !Targeting Enemy!"] call SFSM_fnc_unitData;
         _man doMove (getPos _man);

         //sort enemies according to distance.
         _enemies = [_enemies, [], {_man distance _x }, "ASCEND"] call BIS_fnc_sortBy;
         
        
        {_man doFire _x;
          waitUntil{
              sleep 0.5; 
              _man doFire _x;

              ((!alive _x)  || 
              (!alive _man) || 
              (time > _killTimer)) 
            };
          _man doMove (getPos _x);
        } forEach _enemies;
        [_man, "action", _action] call SFSM_fnc_unitData;
        _man setBehaviour "AWARE";
        _man setCombatBehaviour "AWARE";
  };

true;params['_pos'];
private _available = true;
_pos = _pos vectorAdd [0, 0, 0.7];
private _unitsPresent = (_pos nearEntities ["CAManBase", 2]) select {[_x] call SFSM_fnc_isRealMan};
private _destinations = [] call SFSM_fnc_allCurrentDestinations;
private _nearest = [0,0,0];

if(count _destinations > 0)
then{_nearest = ([_destinations, [], {_pos distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;};

if(_nearest distance _pos < 2)
then{_available = false;};


if!(_unitsPresent isEqualTo [])
then{_available = false;};

_available;params["_man", "_targetHouse"];
private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield = SFSM_Battles get _battleKey;
private _units = missionNamespace getVariable (_battleField get "units");
private _filter = { 
                    private _isClearing = false;
                    private _targetBuilding = [_x, "targetBuilding"] call SFSM_fnc_unitData;
                    _targetBuilding = missionNamespace getVariable _targetBuilding;
                    ((!isNil "_targetBuilding")
                    &&{_targetBuilding == _targetHouse
                    &&{(side _x)==(side _man)}})
                  };
_units = _units select _filter;
private _unitsClearing = count _units;


//return result.
(_unitsClearing >= SFSM_CQBunitCap)private _startPos = [(AGLToASL _x), 1] call Tcore_fnc_addZ;
private _endPos = _startPos vectorAdd [0, 0, 10];
private _indoors = (count (lineIntersectsWith [_startPos, _endPos]) > 0);
(_indoors
&&{[_x] call SFSM_fnc_CQBposAvailable})private _maxTime = 10;
private _maxDistance = 1.1;
params ["_man", "_pos", "_maxTime", "_maxDistance"];
private _timer = time + _maxTime;
private _distance = round(_man distance _pos);

//disable ai functions that disturbs movement
[_man, false] call Tcore_fnc_toggleAiMoveInhibitors;

//disable disturbing behaviour
_man setBehaviour "AWARE";
_man setCombatBehaviour "AWARE";
_man setUnitPos "UP";

//move to position, stop targeting
_man doMove _pos;
_man doTarget objNull;

while {sleep 1; _distance > _maxDistance} do {

//look for and engage close enemies.
private _killEnemies = [_man, _maxTime] spawn SFSM_fnc_CQBTargetEnemies;
waitUntil{scriptDone _killEnemies};


//   private _currentDistance = ((eyePos _man) distance2d _pos);
	private _currentDistance = ((getPos _man) distance _pos);
	private _hasMovedCloser = _distance > _currentDistance;
	if(! _hasMovedCloser)
	then{
			_man doMove _pos;
			_man doTarget objNull;
		};
  
	_distance = _currentDistance;
	if(_distance < _maxDistance)exitWith{false};
	if(time > _Timer)	          exitWith{false};
	if(!alive _man)		          exitWith{false};

};

//enable Standard AI
[_man, true] call Tcore_fnc_toggleAiMoveInhibitors;

true;params["_man", "_building", "_target"];
private _startPos = getPos _man;
private _buildingVarName = ["Occupied building ", (name _man), (getPos _building)] joinString "_";
private _path = [_building, true, _startPos] call SFSM_fnc_buildingPath;
private _cPos = 1;
private _startSpeedMode = speedMode _man;
private _startTime = time;
private _rigged = _building getVariable ["SFSM_explosiveRigged", false];


[_man, "action", "Initializing CQB"] call SFSM_fnc_unitData;
[_man, "targetBuilding", _buildingVarName] call SFSM_fnc_unitData;
missionNamespace setVariable [_buildingVarName, _building];

_man setBehaviour "AWARE";
_man setCombatBehaviour "AWARE";
_man setUnitPos "UP";
_man setAnimSpeedCoef SFSM_sprintSpeed;
_man setSpeedMode "FULL";

private _script = [_man,(_path#0), 6, 5, 2] spawn SFSM_fnc_forceMoveToPos;
waitUntil{scriptDone _script;};


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

  // if all checks passed then move to the next position.
  private _script = [_man, _x, 10, 2] spawn SFSM_fnc_clearCQBPos;
  waitUntil{sleep 1; scriptDone _script;};
  

  //action text for debugPurposes
  private _complPath = round((_cPos / (count _path))*100);
  private _actionText = ["CQB: Clearing house ", _complPath, "%"] joinString "";
  [_man, "action", _actionText] call SFSM_fnc_unitData;

  //count positions cleared
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
true;private _includeExits = false;
params["_building", "_includeExits", "_startPos"];
private _positions = _building buildingPos -1;
private _floorPositions = [_positions] call SFSM_fnc_floorPositions;
private _pathPosArr = [];


{_pathPosArr pushBackUnique _x;} forEach (_floorPositions#0);
if(count _floorPositions > 1)
then{{_pathPosArr pushBackUnique _x;} forEach (_floorPositions#1);};

_pathPosArr=([_pathPosArr, [], {(AGLToASL _x)#2}, "ASCEND"] call BIS_fnc_sortBy);



if(_includeExits)
then{
    private _exits = [_building] call SFSM_fnc_buildingExits;
    if(_exits isEqualTo [])exitWith{};
    if(!isNil "_startPos")
    then{_exits = ([_exits, [], {_startPos distance _x }, "ASCEND"] call BIS_fnc_sortBy);};
    
    _pathPosArr insert [0, [(_exits#0)], false];
    _pathPosArr pushBackUnique (_exits#(count _exits -1));
};


// _pathPosArr = [_pathPosArr] call Tcore_fnc_posArrToPathPosArr;

_pathPosArr;params["_buildingPositions"];
private _floors = 1;
private _zValues = [];
{_zValues pushBack _x#2;} forEach _buildingPositions;

private _diff = (selectMax _zValues) -(selectMin _zValues);

if(_diff > 2)
then{_floors = 2};

_floors;params ["_building"];
private _exits = [];
private _maxZ = 0.8;
for "_i" from 0 to 100 
do{
    private _pos = (_building buildingExit _i);
    if(_pos isEqualTo [0,0,0])exitWith{};
    private _valid = (_pos#2<_maxZ &&{_pos#2>(0-_maxZ)});
    if(_valid)then{_exits pushBackUnique _pos;};
    
};

_exits;params["_man"];

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
true;params["_battleField"];
_battlefield set ["currentAction",	"Assigning buildings"];
private _units = missionNamespace getVariable (_battlefield get "units");

{[_x] call SFSM_fnc_assignBuilding;} forEach _units;

_battlefield set ["currentAction",	"none"];

true;private _targetZ = 2;
private _returnHiddenPositions = false;
params ["_fromPos", "_toPosArr", "_ignoreObj", "_targetZ", "_returnHiddenPositions"];

private _hiddenPositions = [];
private _visibility = [];
private _startPos = AGLToASL _fromPos;

if(count _toPosArr < 1)exitWith{ false}; 

{
	private _targetPos = AGLToASL [_x # 0, _x # 1, _targetZ];
	private _targetObj = (nearestObjects [[_targetPos#0,_targetPos#1], ["Land"], 3])#0;

	if(isNil "_targetObj")then{_targetObj = objNull};
	if(isNil "_ignoreObj")then{_ignoreObj = objNull};

	private _v = ([_ignoreObj, "VIEW", _targetObj] checkVisibility [_startPos, _targetPos]);
	_visibility pushBack _v;

	if(_v < 0.1)then{_hiddenPositions pushback _x};
} forEach _toPosArr;

if(_returnHiddenPositions)exitWith{_hiddenPositions};

private _coef = selectMax  _visibility;

if(isNil "_coef")exitWith{ false};

private _visible = _coef > 0.1;

_visibleparams["_posA", "_posB"];

private _objA = (nearestObjects [[_posA#0,_posA#1], ["Land"], 3])#0;
if(isNil "_objA")then{_objA = objNull};
private _objB = (nearestObjects [[_posB#0,_posB#1], ["Land"], 3])#0;
if(isNil "_objB")then{_objB = objNull};

private _visibility = ([_objA, "VIEW", _objB] checkVisibility [_posA, _posB]);

_visibility;//checks if a unit is visible from an array of positions
private _objRadius = 50;
params ["_unit", "_posArr", "_objRadius"];

private _inCover  = true;
private _headPos   = eyePos _unit;

{
	private _pos       = [_x # 0, _x # 1, 1.9];
	private _targetPos = AGLToASL _pos;
	private _targetObj = (nearestObjects [_targetPos, ["Land"], _objRadius]) # 0;
	if(isNil "_targetObj")then{_targetObj = objNull};
		
	private _visibility = ([_unit, "VIEW", _targetObj] checkVisibility [_headPos, _targetPos]);

	_inCover  = (_visibility < 1);
	systemChat str _visibility;

	if!(_inCover)exitWith{};

}forEach _posArr;

_inCoverprivate _AGLPos = false;
params ["_unitArr", "_AGLPos"];
if(_unitArr isEqualTo [])exitWith{[]};
private _aimPositions = [];

{
  private _pos = aimPos _x;
  if(_AGLPos)then{_pos = ASLToAGL _pos};
  _aimPositions pushBack _pos;
  
} forEach _unitArr;
_aimPositions;params["_man", "_enable"];

if(_enable)
exitwith{
			_man enableAI "TARGET";
			_man enableAI "AUTOCOMBAT";
			_man enableAI "AUTOTARGET";
			_man enableAI "TARGET";
		};

_man disableAI "TARGET";
_man disableAI "AUTOCOMBAT";
_man disableAI "AUTOTARGET";
_man disableAI "TARGET";

true;private _unique = true; 
params["_source", "_target", "_unique"];
private _newArr = _target;

{
	if(_unique)	then{_newArr pushBackUnique _x}
				else{_newArr pushBack       _x};
} forEach _source;

_newArrparams["_string", "_subStrings"];
private _present = false;

{
	if(_x in _string)exitWith{_present = true};
} forEach _subStrings;

_presentparams["_string", "_startString", "_endString"];

private _operators  = "+-*/#()[];,.:%=" splitString "";
private _numbers    = "0123456789_" splitString "";
private _name       = [];
private _iterations = (count _string)-1;


for "_i" from 0 to _iterations
do{
	if(_i == 0
	&& {!isNil "_startString"})
	then{_name pushBack _startString};
	
	private _letter   = _string select [_i, 1];
	private _number   = _letter in _numbers;
	private _operator = _letter in _operators;
	private _excluded = (count _name) == 0 && {_number};
	
	
	if(_excluded)then{_name pushBack "Var_"};
	if!(_operator)
	then{
		  if(_letter == " ")then{_name pushBack "_"}
		  				    else{_name pushBack _letter};
		};
	
	if(_i == _iterations
	&& {!isNil "_endString"})
	then{_name pushBack _endString};	
};

_name = _name joinString "";

_nameprivate _posCount = 10;
private _includeEnds = true;
params ["_start", "_end", "_posCount", "_includeEnds", "_zValue"];
private _positions = [];
private _dir = _start getDir _end;
private _dist = _start distance2D _end;
private _iterationDist = _dist / _posCount;
private _distToNextPos = _iterationDist;

for "_i" from 1 to _posCount do 
{
	private _newPos = [_start#0, _start#1, _dir, _distToNextPos] call Tcore_fnc_sinCosPos;

	if!(isNil "_zValue")then{_newPos = [_newPos#0, _newPos#1, _zValue]};

	_positions pushBack _newPos;
	_distToNextPos = _distToNextPos + _iterationDist;
};

if!(_includeEnds)exitWith{_positions;};

private _returnArr = [_start];
_returnArr append _positions;
_returnArr pushBack _end;

_returnArr;private _posCount = 100;
private _zValue = 0;
private _includeWaterPos = false;
params [
	"_Center", 
	"_Size", 
	"_posCount",
	"_zValue",
	"_includeWaterPos"
	];

private _bottomLeft    = [_center#0, _center#1, 225, (_Size * 0.7071)] call Tcore_fnc_sinCosPos;
private _topLeft       = [_center#0, _center#1, 315, (_Size * 0.7071)] call Tcore_fnc_sinCosPos;
private _cToCdistance  = _bottomLeft distance2D _topLeft;

private _positions   = [];
private _axisCount   = round(_posCount / 10);
private _posDistance = (_cToCdistance / _axisCount);

private _yAxis = [_bottomLeft, _topLeft, (_axisCount-2)] call Tcore_fnc_straightPosArr;

{
	private _westPos = _x;
	private _eastPos = [_westPos#0, _westPos#1, 90, _cToCdistance] call Tcore_fnc_sinCosPos;
	private _newPositions = [_westPos, _eastPos, (_axisCount-2), true, _zValue] call Tcore_fnc_straightPosArr;
	_positions append _newPositions;
} forEach _yAxis;

_positions = _positions select {(_includeWaterPos || (!surfaceIsWater _X))};

_positions;params["_startPos", "_posArr"];
_posArr = ([_posArr, [], {_x distance2D _startPos} , "ASCEND"] call BIS_fnc_sortBy);
_posArr;params ["_OrigX", "_OrigY", "_Dir", "_Distance"];
Private _NewX = ((sin _Dir) * _Distance) + _OrigX;
Private _Newy = ((cos _Dir) * _Distance) + _OrigY;

Private _Pos = [_NewX,_NewY, 0];

_Posparams["_object"];
private _stringName = str _object;

// Old method

// New method
// < "3374684b400# 122614: radar_f.p3d" > Split between : and . because name can't contain these -
// letters so the name is always in between
private _string = (((_stringName splitString ":") # 1) splitString ".") # 0;
private _name = _string select [1, count _string]; // Get rid of the whitespace
if (isNil "_name") then {_name = ""};
_name
private _decimals = 0;
params["_position", "_decimals"];

private _pos = [([(_position # 0), _decimals] call Tcore_fnc_decimals), 
				([(_position # 1), _decimals] call Tcore_fnc_decimals), 
				([(_position # 2), _decimals] call Tcore_fnc_decimals)];

_pos//filters out the positions from an array retrieved from Tcore_fnc_allClustersInRadius
params["_clusterDataArr", "_side"];
private _positions = [];

{
	if(isNil "_side")then{_positions pushBack (_x # 0)}
	else{
			private _posSide = _x # 3;
			
			if(_posSide == _side)
			then{_positions pushBack (_x # 0)};
	};
	
	
}foreach _clusterDataArr;

_positionsparams["_objArr"];
private _posArr = [];

{
   _posArr pushBackUnique (getPos _x);
	
} forEach _objArr;

_posArr;params ["_coverPos", "_posArr"];
private _isCover        = true;
private _stance   	    = "";

{
	
	private _targetPos = AGLToASL [_x # 0, _x # 1, 2];
	_stance = [_coverPos, _targetPos] call Tcore_fnc_coverPosStance;
	_isCover = !(_stance == "none");
	// systemChat _stance;
	if!(_isCover)exitWith{};

}forEach _posArr;

_stanceparams ["_posArr"];
private _end = _posArr#(count _posArr-1);
private _pos = _posArr#0;
private _newArr = [];

private _getNearestXprevious = { 
	//gets the nearest position relative to the current position that has not already been selected.
	params ["_pos", "_posArr", "_previousPositions"];
	private _eligble = _posArr select {!(_x in _previousPositions)};
	private _sortedArr = ([_eligble, [], {_pos distance _x }, "ASCEND"] call BIS_fnc_sortBy);
	private _nextPos = _sortedArr#0;

	_nextPos;
};

{
	private _newPos = [_pos, _posArr, _newArr] call _getNearestXprevious;
	if(_newPos isEqualTo _end)
	exitWith{_newArr pushBackUnique _newPos;};//start && end positions are inserted before calling this function, 
	_newArr pushBackUnique _newPos;           //hence the last pos in the original array is also the last position of the
	_pos = _newPos;                           //path.
} forEach _posArr;

_newArr;params ["_group"];
params ["_object", "_shape"];
private _objData = createHashMap;

private _aslPos  = (getPosASLVisual _object);
private _pos 	 = ASLToAGL _aslPos;

//rounding the coordinates to a max of 2 decimals.
_pos = [_pos, 2] call Tcore_fnc_roundPos;
private _posFirst = _pos # 0;
private _posSecond = _pos # 1;

private _topPos   = 	[_posFirst, 
						 _posSecond, 
						 ((_pos # 2) + (_shape get "height"))];

private _rightPos = 	[_posFirst, 
						 (_posSecond), 
						 (getDir _object) + 90, 
						 (_shape get "width")
						] call Tcore_fnc_sinCosPos;

private _leftPos = 		[_posFirst, 
						 (_posSecond), 
						 (getDir _object) - 90, 
						 (_shape get "width")
						] call Tcore_fnc_sinCosPos;

private _frontPos =		[_posFirst, 
						 (_posSecond), 
						 (getDir _object), 
						 (_shape get "length")
						] call Tcore_fnc_sinCosPos;

private _backPos =		[_posFirst, 
						 (_posSecond), 
						 (getDir _object), 
						 -(_shape get "length")
						] call Tcore_fnc_sinCosPos;



_objData set ["position", _pos];
_objData set ["top",      _topPos];
_objData set ["right",    _rightPos];
_objData set ["left",     _leftPos];
_objData set ["front",    _frontPos];
_objData set ["back",     _backPos];

_objDataprivate _min = false;
params ["_object", "_min"];

private _center     = (boundingCenter _object);
		_center     = [_center, 2] call Tcore_fnc_roundPos;
private _shape		= createHashMap;
private _XYZ 		= (boundingBoxReal _object) select 1;
if(_min)then{_XYZ 	= (boundingBoxReal _object) select 0};
private _X_Y_Ratio	= 0;
private _zeroDivisor= false;

if(_XYZ select 1 == 0
or _XYZ select 0 == 0)
then{_zeroDivisor = true};

if!(_zeroDivisor)
then{_X_Y_Ratio	= (_XYZ select 1) / (_XYZ select 0)};

_shape set ["width",	[(_XYZ select 0), 1] call Tcore_fnc_decimals];
_shape set ["length", 	[(_XYZ select 1), 1] call Tcore_fnc_decimals];
_shape set ["height", 	[(_XYZ select 2), 1] call Tcore_fnc_decimals];
_shape set ["Y to X", 	[_X_Y_Ratio, 1] 	 call Tcore_fnc_decimals];
_shape set ["objCenter",_center];

private _objPosData = [_object, _shape] call Tcore_fnc_objPosData;

{
	_shape set [_x, _y];
} forEach _objPosData;

// _shape set ["objPositions",_objPosData]; 
_shapeparams ["_enemyPosArr", "_objectShape"];
private _pos 			= _objectShape get "position";
private _avgEnemyRelDir = [_enemyPosArr, _pos] call Tcore_fnc_avgRelDir;
private _maxMinDir      = [_enemyPosArr, _pos, true] call Tcore_fnc_avgRelDir;
private _maxDir         = _maxMinDir # 0;
private _minDir         = _maxMinDir # 1;
private _safeDir 		= _avgEnemyRelDir;
private _maxDist        = (selectMax [(_objectShape get "length"), (_objectShape get "width")]) + 0.5; /params["_element"];

if(isNil "_element")exitWith{true;};
if(isNull _element)exitWith{true;};

false;//just a small filtered version of the nearEntities command, 
//excludes players, vehicles and the unit itself.
private _enemiesOnly = false;
params["_man", "_radius", "_enemiesOnly", "_pos"];
if(isNil "_pos")then{
	_pos = getPos _man;//ASLToAGL getPosASL _man;
	// _pos =[_pos#0, _pos#1];
	};
private _nearSoldiers = [];
private _nearMen = _pos nearEntities ["CAManBase", _radius];
		
		{
			private _isPlayer = [_x] call Tcore_fnc_isPlayer;
			private _isThisUnit = (_x == _man);
			private _valid = [_x] call SFSM_fnc_isRealMan;
			private _include = ((! _enemiesOnly) || (!([(side _man), (side _x)] call BIS_fnc_sideIsFriendly)));
			
			if((! _isPlayer)
			&&{(! _isThisUnit)
			&&{_valid
			&&{_include}}})
			then{_nearSoldiers pushBack _x};
			
		} forEach _nearMen;


_nearSoldiers;private _distance = 500;
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




Params ["_Pos", "_ObjArr"];//accepts both positions and objects
Private _minDistance	= 100000;
Private _objDistance	= 100000;
Private _Nearest		= 0;

if(Isnil "_ObjArr"
&&{!Isnil "_Pos"})exitWith{_Pos};

if(Isnil "_Pos"
&&{!Isnil "_ObjArr"})exitWith{_ObjArr select 0};

{
	if!(_x isEqualTo _Pos)
	then{
			_objDistance = (_Pos Distance2d _x);
			If (_objDistance < _minDistance) 
			then 	{
						_minDistance = _objDistance;
						_Nearest	 = _x;
					};
		};
} ForEach _ObjArr;


_Nearestprivate _distance = 500;
params['_man',"_distance"];
private _pos = getPos _man;
private _enemyPositions = [_man, _distance, 'positions'] call Tcore_fnc_nearKnownEnemies;

if(count _enemyPositions == 0)exitwith{};

private _dirToEnemies = [_enemyPositions, _pos] call Tcore_fnc_avgRelDir;

_dirToEnemies = [(_dirToEnemies - 180)] call Tcore_fnc_formatDir;

_dirToEnemiesparams["_man"];

((_man in allPlayers) or isPlayer _man);private _maxDeviation = 3;
Params ["_currentDir", "_targetDir", "_maxDeviation"];
		
		_currentDIr 	= [_currentDir] call Tcore_Fnc_formatDir;
		_TargetDir 		= [_TargetDir] 	call Tcore_Fnc_formatDir;
private _isFacingTarget	= false;
private _DirLow   		= [(_TargetDir - _maxDeviation)] 	call Tcore_Fnc_formatDir;
private _DirHigh  		= [(_TargetDir + _maxDeviation)] 	call Tcore_Fnc_formatDir;


if 	((_CurrentDir == _TargetDir) or
	((_CurrentDir > _DirLow) && (_CurrentDir < _DirHigh)))
	then {_isFacingTarget = true};

_isFacingTarget*
Creates an array of 100 positions within a radius defined by inputParams.
the positions are in AGL format with a z value of 1.5
the function will exclude positions with a water-surface
*/
params ["_Center", "_Size"];
private _iterationDistance	=  _Size / 10;
private _grid = [];

private _startPos 	= 	[
							(_Center select 0) - (_Size / 2),
							(_Center select 1) - (_Size / 2),
							(_Center select 2)
						];

_startPos = [_startPos#0, _startPos#1, 45, (_iterationDistance * 0.75)] call Tcore_fnc_sinCosPos;

private _pos = _startPos;
private _Counter = 1;

for "_I" from 1 to 100 do{

if(_Counter == 11)then{
						_Counter = 1;
						_Pos = 	[
									_startPos select 0,
									(_pos select 1) + _iterationDistance,
									(_pos select 2)
								];
					 };
if(!surfaceIsWater _pos)
then{
		_grid pushBack _pos;
	};



_pos = 	[
			(_pos select 0) + _iterationDistance,
			(_pos select 1),
			1.5
		];
_Counter = (_Counter + 1);
};

_gridASLToAGL getPosASL _this;params ["_posA", "_posB"]; 
private _dir      = _posA getDir _posB;
private _distance = (_posA distance2D _posB) / 2;

private _midpos = [_posA#0, _posA#1, _dir, _distance] call Tcore_fnc_sinCosPos;

_midposprivate _standHeight = false;
params["_man", "_enemies", "_standHeight"];
private _target   = objNull;
private _startPos = ASLToAGL (eyePos _man);

if(_standHeight)
then{_startPos = [_startPos#0, _startPos#1, 1.7]};

_startPos = AGLToASL _startPos;

private _nearest  = [_man, _enemies] call Tcore_fnc_nearestPos;
if(typeName _nearest == "SCALAR")exitWith{objNull};

private _canSee = [_man, "VIEW", _nearest] checkVisibility [_startPos, aimPos _nearest];

if(_canSee > 0.3)exitWith{_nearest};

{
	_canSee = [_man, "VIEW", _x] checkVisibility [_startPos, aimPos _x];
	if(_canSee > 0.1)exitWith{_target = _x};
} forEach _enemies;

_target;params ["_position", "_radius", "_locationTypes"];
private _name = "";
private _pos  = [0,0,0];
{
    if ((text _x) isNotEqualTo "") 
	exitWith{
				_name = text _x; 
				_pos = locationPosition _x;
				
				_name};
} forEach nearestLocations [_position, _locationTypes, _Radius];

[_name, _pos]private _posCount = 32;
params ["_pos", "_radius", "_posCount"];
private _positions = [];
private _dir = 0;
private _dirIncrement = (360 / _posCount);

for "_i" from 0 to (_posCount -1)
do {
		private _newPos = [_pos#0, _pos#1, _dir, _radius] call Tcore_fnc_sinCosPos;
		_positions pushBack _newPos;
		_dir = _dir + _dirIncrement;
   };
_positions;params["_dir"];
_dir = round((_dir + 360) % 360);
_dirparams["_pos", "_searchRadius"];
private _positions = [];
private _validPositions = [];
params["_distance"];
private _description = "0m";
private _km = [(_distance / 1000), 1] call Tcore_fnc_decimals;
private _m  = round(_distance);

if(_distance < 1000)
exitWith{
			_description = [_m, " meters"] joinString "";
			_description;
		};

_description = [_km, " kilometers"] joinString "";
_description;params["_dir"];
private _dir = [_dir] call Tcore_fnc_formatDir;

if(_dir < 22.5
or _dir >= 337.5)exitWith{"north"};

if(_dir > 22.5
&& _dir <= 67.5)exitWith{"north-east"};

if(_dir > 67.5
&& _dir <= 112.5)exitWith{"east"};

if(_dir > 112.5
&& _dir <= 157.5)exitWith{"south-east"};

if(_dir > 157.5
&& _dir <= 202.5)exitWith{"south"};

if(_dir > 202.5
&& _dir <= 247.5)exitWith{"south-west"};

if(_dir > 247.5
&& _dir <= 292.5)exitWith{"west"};

if(_dir > 292.5
&& _dir <= 337.5)exitWith{"west"};

" of "private _maxDecimals = 0;
params ["_number", "_maxDecimals"];
// Old method

// New method 
parseNumber (_number toFixed _maxDecimals);
private _print = true;
private _log   = true;
private _displayType = 1;
private _signature = "***Tcore Debug mesage***";

params[	"_text", 
		"_print", 
		"_log", 
		"_displayType",
		"_signature"
	  ];


if(typeName _this == "STRING")  then{_text = _this};
if(typeName _text == "ARRAY")	then{_text = _text joinString ""};
if!(typeName _text == "STRING")	then{_text = str _text};


if(_log)then{diag_log [_signature, _text] joinString ""};

if!(_print)exitWith{_text};

switch (_displayType) 
do {
	case 1: { systemChat _text};
	case 2: { hint _text};
};
_text;params ["_pos", "_radius"];
private _deadMenInArea = [];
{
	private _distance = _pos distance2D _X;
	
	if(_distance < _radius)then{_deadMenInArea pushback _X};
	
} forEach alldeadMen;

_deadMenInArea;params ["_Vehicle"];
private _Group   = (group _Vehicle);
private _AllDead = true;

if(IsNil "_Vehicle")			exitWith{true};
if((crew _Vehicle) isEqualTo [])exitwith{true};
if(!Alive _Vehicle)				exitWith{true};
if(IsNil "_Group")				exitWith{true};
if(IsNull _Group) 				exitWith{true};


{if(alive _X)exitWith{_AllDead = false}} forEach (Crew _Vehicle);





_AllDeadparams ["_coverPos", "_targetPos"];
// private _isCover        = true;
private _exposed 		= false;
private _counter 		= 0;
private _visibility 	= 1000;
private _stance 		= "none";
private _targetPos      = AGLToASL _targetPos;
private _standPos       = AGLToASL [_coverPos # 0, _coverPos # 1, 1.75];
private _crouchPos      = AGLToASL [_coverPos # 0, _coverPos # 1, 1.1];
private _pronePos       = AGLToASL [_coverPos # 0, _coverPos # 1, 0.4];
private _coverPositions = [_standPos, _crouchPos, _pronePos];
private _stances 		= ["ERECT", "CROUCH", "PRONE"];
private _ignoreObj      = (nearestObjects [_coverPos, ["CAManBase"], 5]) # 0;
private _ignoreObj2     = (nearestObjects [_coverPos, ["CAManBase"], 5]) # 0;

if(isNil "_ignoreObj")then {_ignoreObj = objNull};
if(isNil "_ignoreObj2")then{_ignoreObj2 = objNull};


{
	private _tLos = terrainIntersect [ASLToAGL _x, ASLToAGL _targetPos];
	if(_tLos)
	exitWith {
		_stance = (_stances # _counter); 
		// diag_log "terrain";
		};


	private _objs = lineIntersectsObjs [_x, _targetPos, _ignoreObj, _ignoreObj2, false, 32];
	
	// diag_log [_objs] joinString "";
	
	private _exposed = (_objs isEqualTo []);
	if!(_exposed)exitWith{_stance = (_stances # _counter)};

	_counter = _counter + 1;
}forEach _coverPositions;

_stanceprivate _radius = 30;
params ["_man", "_radius"];
private _coverObjects = nearestTerrainObjects 
						[(getPos _man), 
						["TREE", "SMALL TREE", "BUSH", "HOUSE", "ROCK", "ROCKS", "WALL"], 
						_radius, 
						false, 
						true];

if(_coverObjects isEqualTo []) exitWith {};

_coverObjects deleteAt (_coverObjects findIf {isHidden _x});
private _coverObject = selectRandom _coverObjects;

_coverPos = (getPos _coverObject);

_coverPosparams["_clustersDataArr"];
private _vehicles   = [];

{
	private _objects    = _x#1;
	private _iterations = (count _objects)-1;

	for "_i" from 0 to _iterations
	do{
		private _object = _objects#_I;

		if!(_object isKindOf "man")
		then{_vehicles pushBackUnique _object};
	};

} forEach _clustersDataArr;

_vehiclesparams["_clustersDataArr"];
private _units   = [];

{
	private _objects    = _x#1;
	private _iterations = (count _objects)-1;

	for "_i" from 0 to _iterations
	do{
		private _object = _objects#_I;

		if(_object isKindOf "man")
		then{_units pushBackUnique _object};
	};

} forEach _clustersDataArr;

_unitsparams ["_hashmap", "_clusterDataArr"];
private _terrainObjects = createHashMap;
private _positions = [];

for "_i" from 0 to (count _clusterDataArr)-1
do{
		private _clusterData   = (_clusterDataArr # _i);
		private _objectDataArr = _clusterData select 4;
		
		{
			private _pos = call compile _X;
			_positions pushback _pos;
			_hashmap        set [_X, _Y];
			_terrainObjects set [_X, _Y];
		}foreach _objectDataArr;
  };

_hashmap        set ["positions", _positions];
_terrainObjects set ["positions", _positions];


_terrainObjectsparams ["_center", "_clusterMembers"];
if(count _clusterMembers < 2)exitWith{2};
private _distances = [];
if(isNil "_center")then{["nil pos", 2] call SFSM_fnc_debugMessage};

{
	if(!isNil "_center")
	then{_distances pushback (_x distance2D _center)}	
} forEach _clusterMembers;

private _clusterRadius = selectMax _distances;

if(isNil "_clusterRadius")then{_clusterRadius = 2};

_clusterRadiusparams ["_clustersDataArr"];
private _sides = [];
{
	private _side = _X # 3;
	_sides pushBackUnique _side;
	
}foreach _clustersDataArr;

_sides private _Radius 			= 50;
private _Zvalue				= 1;
private _excludedUnits      = [];
private _returnValueType 	= "position";
private _includeTerrainObjects = false;

params [	"_target", 
			"_Radius", 
			"_Zvalue", 
			"_excludedUnits", 
			"_returnValueType",
			"_includeTerrainObjects"
		];

if((typeName _target) == "BOOL")exitWith{systemChat "B..."; nil};

private _Side 			= (side _target);
Private _Pos 			= (GetPos _target);
private _list 			= (_Pos nearEntities ["Land", _radius]);
Private _Yarr 			= [];
Private _Xarr 			= [];
private _clusterObjects	= [_target];
private _groups         = [];

_list PushBackUnique _target;

{
	if 	((Side _x) == (_Side)
	&&	{!(_x in _excludedUnits)})
	then 	{
			
				Private _Xpos   = (round ((Getpos _x) select 0));
				Private _Ypos   = (round ((Getpos _x) select 1));
				_Yarr PushBackUnique _Ypos;
				_Xarr PushBackUnique _Xpos;

				_clusterObjects PushBackUnique _x;
				_groups PushBackUnique (group _x);
			};
}ForEach _list;

if(count _list <= 1)exitWith{_Pos};

private _avgX = ([_Xarr] Call Tcore_Fnc_average);
private _avgY = ([_Yarr] Call Tcore_Fnc_average);

Private _Returnpos   = [_avgX, _avgY, _Zvalue];
private _clusterRadius = ceil([_Returnpos, _clusterObjects] call Tcore_fnc_clusterSize); 

If (Isnil "_Returnpos"
or _Returnpos isEqualTo [0,0,0]) 
then {_Returnpos = _Pos};

private _terrainObjects = createHashmap;
if(_includeTerrainObjects)
then{
		private _types = ["TREE", "SMALL TREE", "BUSH", "HOUSE", "ROCK", "ROCKS", "WALL"];
		[_Returnpos, _Radius, _terrainObjects, nil, _types] call SFSM_fnc_getMapObjects; 
	};


if(_returnValueType == "position")	exitWith{_Returnpos};
if(_returnValueType == "objects")	exitWith{_clusterObjects};
if(_returnValueType == "size")		exitWith{_clusterRadius};
if(_returnValueType == "all")		exitWith{[_Returnpos, _clusterObjects, _clusterRadius, _Side, _terrainObjects, _groups]};

_Returnposparams ["_dataArr"];
private _pos 	     = _dataArr # 0;
private _radius      = _dataArr # 2;
private _side 	     = _dataArr # 3;
private _color	     = "ColorOrange";//[0.85,0.4,0,1];
if(isNil "Tcore_debugMarkers")then{Tcore_debugMarkers = []};
private _markerCount = count Tcore_debugMarkers;
private _markerName  = [(round((random 1) * 100000)), "_clusterMarker_", _markerCount] joinString "";


switch (_side) do {
					case east:        {_color = "ColorEAST"};
					case west:        {_color = "ColorWEST"};
					case independent: {_color = "ColorGUER"};
				   };
private _marker = createMarker [_markerName, _pos];

_markerName setMarkerShape "ELLIPSE";
_markerName setMarkerSize  [_radius, _radius];
_markerName setMarkerColor _color;
_markerName setMarkerAlpha 1;

_markerNameparams ["_clustersDataArr"];
private _groups = [];
{
	private _grps = _X # 5;
	_groups append _grps;
	
}foreach _clustersDataArr;

_groupsprivate _radius = 2000;
params ["_position", "_Radius"];
private _locationName = "unknown";
private _locationPos  = [0,0,0];
private _allLocationTypes = [
								["NameCityCapital"],
								["NameCity"],
								["NameVillage"],
								["NameMarine"],
								["NameLocal"]
							];

{
	private _namePos = [_position, _radius, _x] call Tcore_fnc_getLocationNamePos;
	private _name    = _namePos # 0;
	if!(_name == "")
	exitWith{
				_locationName = _name;
				_locationPos  = _namePos # 1;
			};
}forEach _allLocationTypes;


[_locationName, _locationPos]//Description: Returns the average relative direction to a position from an array of positions.
//Does accept objects as well as positions.
//For a maxdir and minDir return then set 3rd param as true (default is false)
private _maxMin = false;
params["_posArr", "_relPos", "_maxMin"];
private _relDirs   = [];

{
	
			_relDirs pushBackUnique (_x getDir _relPos) call Tcore_fnc_formatDir;
	
} forEach _posArr;

private _avgDir = ([_relDirs] call Tcore_fnc_average);//[([_relDirs] call Tcore_fnc_average)] call Tcore_fnc_formatDir;

// diag_log [_relDirs, "---> avg: ", _avgDir] joinString "";

if!(_maxMin)exitWith{_avgDir};


[(selectMax _relDirs), (selectMin _relDirs)];params["_posArr"];
if(count _posArr == 0)exitWith{[]};
if(count _posArr < 2)exitWith{_posArr#0};

Private _Xarr 			= [];
Private _Yarr 			= [];

{
	_Xarr pushback _x#0;
	_Yarr pushback _x#1;
} forEach _posArr;

private _XX = [_Xarr] call Tcore_fnc_average;
private _YY = [_Yarr] call Tcore_fnc_average;

[_XX, _YY, 0];Params ["_PosArr"];
Private _Heights = [];
private _AverageHeight = 0;


if (Count _PosArr > 1) then {
								{
										private _elevation = (round getTerrainHeightASL _x);
										If (TypeName _elevation == "SCALAR") then {_Heights Pushback _elevation};
										 
								}forEach _PosArr;

								If (Count _Heights > 0) then {_AverageHeight = (round ([_Heights] call Tcore_Fnc_average))};
							};

If (IsNil "_AverageHeight") then {_AverageHeight = 0;};

_AverageHeight;
_exactCalculation = false;
params ["_Arr", "_exactCalculation"];
if(count _Arr == 0)exitWith{0};
Private _NewArr = [];

{If(TypeName _X == "SCALAR")then{_NewArr Pushback _X}}ForEach _Arr;

_Arr = _NewArr;

if(count _Arr == 0)exitWith{0};

private _Length = (Count _Arr);
private _sum = 0;

for "_i" from 0 to (_Length - 1) do {_sum = ((_sum) + ((_Arr) select _i))};

if(_sum == 0)exitWith{0};

Private _Average = (round (_sum / _Length));
if (_exactCalculation) then{_Average = (_sum / _Length)};

_Average private _radius = 1000;
params ["_pos", "_radius"];
private _locationNamePos = [_pos] call Tcore_fnc_closestLocationName;
private _locName         = _locationNamePos # 0;
private _locPos          = _locationNamePos # 1;

if(_locName == "unknown")then{_locPos = _pos};

private _strDir		     = [(_locPos getDir _pos)] call Tcore_fnc_describeDir;
private _distance        = _locPos distance2D _pos;
private _strDist         = [_distance] call Tcore_fnc_describeDistance;
private _areaName        = [_strDist, " ", _strDir, " of ", _locName] joinString "";

if(_distance < 300)then{_areaName = _locName};

_areaName//Defining default values, in case these are not passed into the function
// 
// EXAMPLE: [(getPos player), west, true] call Tcore_fnc_allClustersInRadius
// 
private _sides			 = [east, west, independent];
private _returnAllData   = false; 
private _radius 		 = 500;
private _clusterRadius 	 = 50;
private _Zvalue			 = 2;
private _includeTerrainObjects = false;

params[
		"_center", 
		"_sides",
		"_returnAllData",
		"_radius",
		"_clusterRadius", 
		"_Zvalue",
		"_includeTerrainObjects"
	];

if(typeName _sides == "SIDE")			then{_sides = [_sides]};

private _allUnitsVeh 	= _center nearEntities ["CAManBase", _radius];
private _positions      = [];
private _dataArr		= [];
private _excludedUnits  = [];

for "_I" from 0 to ((count _allUnitsVeh) -1)
do {
		private _unit = _allUnitsVeh select _I;
		private _side = side _unit;
		
		if((!(_unit in _excludedUnits))
		&&{_side in _sides
		&& {[_unit] call SFSM_fnc_isRealMan}})
		then{
				private _clusterData    = [	_unit, 
											_clusterRadius, 
											_Zvalue,
											_excludedUnits, 
											"all",
											_includeTerrainObjects
										  ] call Tcore_fnc_clusterPos;

				private _clusterPos     = _clusterData # 0;
				private _clusterMembers = _clusterData # 1;
				
				
				if((!isNil "_clusterMembers")
				&&{(typeName _clusterMembers == "ARRAY")
				&&{count _clusterMembers >0}})
				then{
						 _positions pushBackUnique _clusterPos;
						 _dataArr   pushBackUnique _clusterData;
						_excludedUnits append _clusterMembers;
					};
			};
	};

if(_returnAllData)exitWith{_dataArr};

_positionsparams["_Position", "_valueToAdd"];
if(!(typeName _Position == "ARRAY"))exitWith{["non-array data passed to the Add Z function"] 	call debugMessage};
if(count _Position < 3)exitWith{["less than 3 coordinates passed to the Add Z function"] 	call debugMessage};
private _newPos = [_Position select 0,
				   _Position select 1,
				   (_Position select 2) + _valueToAdd];


_newPosparams ["_pos", "_areaName", "_radius"];


if(worldName == "Tanoa")exitWith{true};

private _inUrbanArea = (count (_areaName splitString " ")) == 1;
if(_inUrbanArea)exitWith{true};


private _distToWineYard = _pos distance2d getPos (nearestLocation [_pos, "VegetationVineyard"]);
private _wineYardInArea = (_distToWineYard < _radius);
if(_wineYardInArea)exitWith{true};
if(_radius > 500)exitWith{true};

false;params ["_battlefield"];
Private _mapObjects    = missionNamespace getVariable (_battlefield get "mapObjects");
Private _hunkerObjData = _mapObjects get "hunkerObjData";
private _hnkObjects    = missionNamespace getVariable (_battlefield get "hunkerObjects");
private _activeSides   = (_battlefield get "sides") call SFSM_fnc_sidesFromString;
{
	[_x, _battlefield, _hunkerObjData, _hnkObjects] call SFSM_fnc_filterHunkerObjects;
} forEach _activeSides;

true;params["_battlefield"];

_battlefield set ["currentAction",	"updating grid"];
private _gridHash      = missionNamespace getVariable (_battlefield get "grid");
private _gridPositions = _gridHash get "gridPositions";
private _clusterHash   = _battlefield get "clusterPositions";

private _westPositions = _clusterHash get "west";
private _eastPositions = _clusterHash get "east";
private _guerPositions = _clusterHash get "independent";

private _hiddenFromWest = [];
private _hiddenFromEast = [];
private _hiddenFromGuer = [];

{
	private _westVisible = [_x, _westPositions] call Tcore_fnc_visibleFromPositions;
	private _eastVisible = [_x, _eastPositions] call Tcore_fnc_visibleFromPositions;
	private _guerVisible = [_x, _guerPositions] call Tcore_fnc_visibleFromPositions;

	if!(_westVisible)then{_hiddenFromWest pushBackUnique _x};
	if!(_eastVisible)then{_hiddenFromEast pushBackUnique _x};
	if!(_guerVisible)then{_hiddenFromGuer pushBackUnique _x};

} forEach _gridPositions;


_gridHash set ["hiddenFromWest", _hiddenFromWest];
_gridHash set ["hiddenFromEast", _hiddenFromEast];
_gridHash set ["hiddenFromGuer", _hiddenFromGuer];

_battlefield set ["currentAction",	"none"];

true;params ['_battleField'];
if(isNil "_battleField")exitWith{"Battlefield nil, cannot update" call SFSM_fnc_debugMessage; true};

private _action   = _battlefield get "currentAction";

if!(_action == "none")exitWith	{
									"Could not update battlefield " call dbgmsg; 
									false;
								};

_battlefield set ["currentAction",	"updating"];

private _markers   = _battlefield get "markers"; 
private _centerPos = _battlefield get "center";
private _radius    = _battlefield get "radius";
private _sides     = [east, west, independent];
private _battleKey = (str _centerPos);
private _areaName  = (_battlefield get "name");


//update all data related to unitClusters.
private _clustersData = [
							_centerPos,	// center of area
							_sides, 	// sides
							true,		// return all data
							_radius,	// AreaRadius
							50,			// ClusterRadius
							2,			// height of returned positions (AGL)
							false		// include terrainObjects
						] call Tcore_fnc_allClustersInRadius;

private _unitFilter = {
	(!(_x getVariable ["SFSM_Excluded",false]))
	&&{(typeOf _x) == (typeOf (vehicle _x))}
	};


private _mapObjsData = missionNamespace getVariable (_battleField get "mapObjects");
private _groups      = [_clustersData]       call Tcore_fnc_clusterGroups;
private _units       = [_clustersData]       call Tcore_fnc_clusterUnits select _unitFilter;
private _vehicles    = [_clustersData]       call Tcore_fnc_clusterVehicles;
private _deadMen     = missionNamespace getVariable (_battleField get "deadMen");

private _weapons = nearestObjects [_centerPos, ["WeaponHolder", "WeaponHolderSimulated"], _radius];

//see comments at Fn_initBattlefield.sqf
[
	_centerPos, 
	_radius, 
	_battlefield, 
	_clustersData, 
	_mapObjsData, 
	false, 
	true
] call SFSM_fnc_areaData;


//store the variables that are not included in the "battlefield"-hashmap itself.
[
	_battlefield, 
	_clustersData, 
	_weapons,
	_units,
	_deadMen,
	_vehicles, 
	_groups, 
	_areaName, 
	_mapObjsData
] call SFSM_fnc_battlefieldVariables;



//zones refer to the average position of each side involved in the fight, 
//the radius of the zone is defined by the distance of the 2 units the furthes away from eachother.
//the zones are used to retrieve cover-positions
_battlefield set ["zones", ([_battlefield] call SFSM_fnc_getZones)];


[_battlefield] call SFSM_fnc_getCoverPositionsLight;
[_battlefield] call SFSM_fnc_updateHunkerObjects;

{
	[_x, "currentBattle", _battleKey] call SFSM_fnc_unitData;
	[_x, _battleField] call SFSM_fnc_reactToVehicles;
} forEach _units;

{[_x, "currentBattle", _battleKey] call SFSM_fnc_vehicleData;} forEach _vehicles;


{[_x, "currentBattle", _battleKey] call SFSM_fnc_groupData} forEach _groups;
{deleteMarker _x} forEach _markers;
[_battlefield] call SFSM_fnc_bfDebugMarkers;


_battlefield set ["lastDataUpdate", time];
_battlefield set ["currentAction",	"none"];

private _battleOver = [_battlefield] call SFSM_fnc_battleEnded;

if(_battleOver)exitWith{[_battleKey] call SFSM_fnc_battlefieldEnd; true};

_battleOver;params ["_unit"];
// if(time - SFSM_lastShotFired < 2) exitWith {};

private _startBattle = [_unit] call SFSM_fnc_canTriggerBattleShot;
if!(_startBattle)exitWith{};

private _target = getAttackTarget _unit;
[_unit, _target] call SFSM_fnc_InitBattlefield;

true;private _string = _this;

// (typeName _string) call dbgmsg;
// _string call dbgmsg;
private _stringArr = _string splitString "[,]";
private _sides = [];

{
	if!(_x == "GUER")then{_sides pushBack (call compile _x)}
					 else{_sides pushBack independent};
} forEach _stringArr;

_sidesparams["_man", "_weaponObject"];


//Double check that the weapon is not being picked up by someone else.
//Due to the speed of the function sometimes the same weapon gets 2 soldiers trying to pick it up,
//inspite of the fact that the variable is declared on the weapon-object.
private _weaponOwner     = _weaponObject getVariable "SFSM_newOwner";
private _weaponAvailable = (isNil "_weaponOwner");
if!(_weaponAvailable)then{_weaponAvailable = (!alive _weaponOwner)};
if!(_weaponAvailable)
then{
		private _battleKey   = [_man, "currentBattle"] call SFSM_fnc_unitData;
		private _battleField =  SFSM_Battles get _battleKey;
		if(isNil "_battleField")exitWith{_weaponObject = nil};
		_weaponObject = [_man, _battleField] call SFSM_fnc_getBattlefieldWeapon;
	};
if(isNil "_weaponObject")exitWith{[_man, false] spawn SFSM_fnc_endWeaponPickup};


//set a variable to ensure no other units try to pick up the same weapon
_weaponObject setVariable ["SFSM_newOwner", _man];


//check if weapon can be picked up
private _canPickUp = [_man, _weaponObject] call SFSM_fnc_canPickUpWeapon;
if!(_canPickUp)exitWith{[_man, false] spawn SFSM_fnc_endWeaponPickup};



//make sure unit is available before executing move
private _timer  = time + 20;
private _available = [_man, _timer] call SFSM_fnc_manAvailable;
if!(_available)
then{
	waitUntil {
		if(isNil "_man")exitWith{true};
		sleep 0.1; 
		[_man, _timer] call SFSM_fnc_manAvailable;
		};
	};

if(isNil "_man")exitWith{};

_available = [_man, (time + 5)] call SFSM_fnc_manAvailable;
_canPickUp = [_man, _weaponObject] call SFSM_fnc_canPickUpWeapon;

//check conditions again
if!(_available)exitWith{[_man, false] spawn SFSM_fnc_endWeaponPickup};
if!(_canPickUp)exitWith{[_man, false] spawn SFSM_fnc_endWeaponPickup};



[_man, "action", "Picking up weapon"] call SFSM_fnc_unitData;


//move to weapon
_man setAnimSpeedCoef SFSM_sprintSpeed;
private _weaponPos = getPos _weaponObject;
[_man, "currentDestination", _weaponPos] call SFSM_fnc_unitData;

private _script = [_man, _weaponPos, 40, 1.5] spawn SFSM_fnc_forceMoveToPos;
waitUntil{sleep 0.1; scriptDone _script};

if(isNil "_man")exitWith{};

_canPickUp      = [_man, _weaponObject] call SFSM_fnc_canPickUpWeapon;
private _tooFar = (_weaponPos distance2D _man) > 3;


//check conditions again
if((! _canPickUp)
or (_tooFar))
exitWith{[_man, false] spawn SFSM_fnc_endWeaponPickup};


//pick up weapon
private _weaponOwner = _weaponObject getVariable "SFSM_weaponOwner";
private _weaponType  = getWeaponCargo _weaponObject#0#0;



if(isNil "_weaponType")
exitWith{[_man, false] spawn SFSM_fnc_endWeaponPickup};

_man action ["TakeWeapon", _weaponObject, _weaponType];

if(isNil "_weaponOwner")exitWith{[_man, true] spawn SFSM_fnc_endWeaponPickup};

//if the weapon was dropped by a killed soldier
sleep 1.5;
_man action ["rearm", _weaponOwner];

//make sure man has no backpack
private _hasBackPack = !isNull (unitBackpack _man);
if(_hasBackPack)exitWith{[_man, true] spawn SFSM_fnc_endWeaponPickup};

//make sure dead body has a backpack
_hasBackPack = !isNull (unitBackpack _weaponOwner);
if!(_hasBackPack)exitWith{[_man, true] spawn SFSM_fnc_endWeaponPickup};

//take backpack from dead Body.
sleep 1.5;
_man action ["AddBag", _weaponOwner, (Backpack _weaponOwner)];

sleep 1.5;
[_man, true] spawn SFSM_fnc_endWeaponPickup;

true;params["_position"];
if(count SFSM_battles < 1)exitWith{objNull};

private _battlePositions = [];
{
	private _battlePosition = _y get "center";
	_battlePositions pushBackUnique _battlePosition;
} forEach SFSM_battles;

private _nearestPos = [_position, _battlePositions] call Tcore_fnc_nearestPos;


_nearestBattle = SFSM_battles get (str _nearestPos);

if(isNil "_nearestBattle")exitWith{objNull};

_nearestBattleparams["_battlefield"];
private _startTime     = time;
private _areaName      = _battlefield get "name";
private _hashmap       = createHashmap;
private _gridVarName   = [_areaName, "Battle_", "_Grid"] call Tcore_fnc_stringToVarName;
private _centerPos     = _battlefield get "center";
private _size          = (_battlefield get "radius")*2.5;
private _gridPositions = [_centerPos, _size] call Tcore_fnc_grid100Pos;

private _clusterHash   = _battlefield get "clusterPositions";

private _westPositions = _clusterHash get "west";
private _eastPositions = _clusterHash get "east";
private _guerPositions = _clusterHash get "independent";

private _hiddenFromWest = [];
private _hiddenFromEast = [];
private _hiddenFromGuer = [];

{
	private _westVisible = [_x, _westPositions] call Tcore_fnc_visibleFromPositions;
	private _eastVisible = [_x, _eastPositions] call Tcore_fnc_visibleFromPositions;
	private _guerVisible = [_x, _guerPositions] call Tcore_fnc_visibleFromPositions;

	if!(_westVisible)then{_hiddenFromWest pushBackUnique _x};
	if!(_eastVisible)then{_hiddenFromEast pushBackUnique _x};
	if!(_guerVisible)then{_hiddenFromGuer pushBackUnique _x};

} forEach _gridPositions;

_hashmap set ["gridPositions",  _gridPositions ];
_hashmap set ["hiddenFromWest", _hiddenFromWest];
_hashmap set ["hiddenFromEast", _hiddenFromEast];
_hashmap set ["hiddenFromGuer", _hiddenFromGuer];


missionNamespace setVariable [_gridVarName, _hashmap];

_battlefield set ["grid", _gridVarName];
_battlefield set ["gridLoaded", true];

private _timeToInit = time - _startTime;

[["grid was initialized in ", _timeToInit, "seconds"]] call dbgmsg;

true;//unit 1 && unit 2 refers to the two units who first spot eachother.
params ["_unitA", "_unitB"];

"Initializing battle." call SFSM_fnc_debugMessage;

private _battlefield  = createHashmap;
private _startTime    = time;
private _posA         = [([_unitA] call Tcore_fnc_clusterPos)] call Tcore_fnc_roundPos;
private _posB         = [([_unitB] call Tcore_fnc_clusterPos)] call Tcore_fnc_roundPos;
private _radius       = round((_posA distance2D _posB) / 1.8);
private _centerPos    = [([_posA, _posB] call Tcore_fnc_getMidpoint)] call Tcore_fnc_roundPos;
		_radius       = [_centerPos, _radius] call SFSM_fnc_battlefieldRadius;
private _battleKey    = (str _centerPos);
private _sides        = [east, west, independent];
private _markers      = [];

_battlefield set ["currentAction",	"initializing"];
_battlefield set ["center",	        _centerPos];
_battlefield set ["markers",		_markers];
_battlefield set ["Started", 		_startTime];
_battlefield set ["lastDataUpdate", -300];
_battlefield set ["lastGunshot",    -300];
_battlefield set ["radius", 		_radius];
_battlefield set ["gridLoaded", 	false];
_battlefield set ["terrainLoaded", 	false];

SFSM_Battles set [_battleKey, _battlefield];

private _clustersData = [
							_centerPos,	// center of area
							_sides, 	// sides
							true,		// return all data
							_radius,	// AreaRadius
							50,			// ClusterRadius
							2,			// height of returned positions (AGL)
							true		// include terrainObjects
						] call Tcore_fnc_allClustersInRadius;

[["Loaded clusterPositions in ",(time - _startTime)," seconds."]] call SFSM_fnc_debugMessage;

private _mapObjsData = createHashmap;

//the following function will get all the info on the map-objects in the area.
//it will get the objects inside the cluster-zones using a unscheduled call
//then it will use a scheduled call (spawn) to aquire all of the map-objects within the battlefield radius.
//This might take some time depending on the amount of objects in the area.
[_centerPos, _radius, _battlefield, _clustersData, _mapObjsData, true] call SFSM_fnc_areaData; 

private _unitFilter = {
	(!(_x getVariable ["SFSM_Excluded",false]))
	&&{(typeOf _x) == (typeOf (vehicle _x))}
	};


private _groups          = [_clustersData] call Tcore_fnc_clusterGroups;
private _units           = ([_clustersData] call Tcore_fnc_clusterUnits) select _unitFilter;
private _vehicles        = [_clustersData] call Tcore_fnc_clusterVehicles;
private _areaName        = _battlefield get "name";
private _deadMen         = [_centerPos, _radius] call Tcore_fnc_deadMenInArea;


private _weapons = nearestObjects [_centerPos, ["WeaponHolder", "WeaponHolderSimulated"], _radius];

//store the variables that are not included in the "battlefield"-hashmap itself.
[
	_battlefield, 
	_clustersData, 
	_weapons,
	_units,
	_deadMen,
	_vehicles, 
	_groups, 
	_areaName, 
	_mapObjsData
] call SFSM_fnc_battlefieldVariables;

_battlefield set ["zones", ([_battlefield] call SFSM_fnc_getZones)];

{[_x, "currentBattle", _battleKey] call SFSM_fnc_vehicleData;} forEach _vehicles;
{[_x, "currentBattle", _battleKey] call SFSM_fnc_unitData} forEach _units;
{[_x, "currentBattle", _battleKey] call SFSM_fnc_groupData} forEach _groups; 


//initGrid will create a hashmap containing 100 positions, and 3 arrays containing positions hidden from clusters divided by side.
[_battlefield] spawn SFSM_fnc_initGrid;

//Records the house a soldier is inside, in said units hashmap.
// [_battleField] spawn SFSM_fnc_assignAllBuildings;



[_battlefield] call SFSM_fnc_getCoverPositionsLight;
 
[["Battle at ", _areaName, " initialized in ", (time - _startTime), " seconds"]] call SFSM_fnc_debugMessage;

[_battlefield] call SFSM_fnc_bfDebugMarkers;

_battlefield set ["currentAction",	"loading terrain"];

[_battlefield] spawn SFSM_fnc_battlefieldPostInit;

_battleKey; params["_battlefield"];
private _minRadius        = (_battlefield get "radius")/4;
private _zones            = createHashmap;
private _clusterPositions = _battlefield get "clusterPositions";
private _center           = _battlefield get "center";

private _westPositions = _clusterPositions get "west";
private _eastPositions = _clusterPositions get "east";
private _guerPositions = _clusterPositions get "independent";


private _westZone    = [_westPositions, _minRadius] call SFSM_fnc_getZone;
private _eastZone    = [_eastPositions, _minRadius] call SFSM_fnc_getZone;
private _guerZone    = [_guerPositions, _minRadius] call SFSM_fnc_getZone;

_zones set ["west",        _westZone];
_zones set ["east",        _eastZone];
_zones set ["independent", _guerZone];

_zones;params ["_positions", "_minRadius"];
private _center = [_positions] call Tcore_fnc_avgPos;
private _radius = 0;

if!(_center isEqualTo [])
then{
		_radius = [_center, _positions] call Tcore_fnc_clusterSize;
		_radius = _radius*1.2;
		if(_radius < _minRadius)then{_radius = _minRadius};
	
	};

[_center, _radius];//Returns an array of positions in AGL format
params["_side", "_battleField"];
private _clusterPositions = (_battlefield get "clusterPositions");
if(isNil "_clusterPositions")exitWith{[]};
private _enemyPosArr = (_clusterPositions get "east") + (_clusterPositions get "independent");
if(_side == east)       then{_enemyPosArr = (_clusterPositions get "west") + (_clusterPositions get "independent")};
if(_side == independent)then{_enemyPosArr = (_clusterPositions get "east") + (_clusterPositions get "west")};
_enemyPosArrparams["_battlefield"];
private _sides = (_battlefield get "sides") call SFSM_fnc_sidesFromString;
private _coverPositionsLight = createHashmap;
if(count _sides < 2)exitWith{_coverPositionsLight};

private _clusterData      = missionNamespace getVariable (_battlefield get "clusterData");
private _mapObjects       = missionNamespace getVariable (_battlefield get "mapObjects");
private _clusterPositions = (_battlefield get "clusterPositions");

private _coverPositionsWest = [];
private _coverPositionsEast = [];
private _coverPositionsGuer = [];
private _allPositions       = []; 
private _isBuilding = {_x isKindOf "house" && {count (_x buildingPos -1) > 3}};

// private _buildings = _mapObjects select _isBuilding;

{
	private _sideAndPos  = [_x, _mapObjects, _clusterPositions] call SFSM_fnc_clusterCoverPosLight;
	private _side      = _sideAndPos#0;
	private _positions = _sideAndPos#1;



	_allPositions append _positions;

	if(_side == west)       then{_coverPositionsWest append _positions};
	if(_side == east)       then{_coverPositionsEast append _positions};
	if(_side == independent)then{_coverPositionsGuer append _positions};

} forEach _clusterData; 


_coverPositionsLight set ["west", 		 _coverPositionsWest];
_coverPositionsLight set ["east", 		 _coverPositionsEast];
_coverPositionsLight set ["independent", _coverPositionsGuer];

_battlefield set ["coverPositions", _coverPositionsLight];
// _battlefield set ["buildings", _buildings];

_coverPositionsLightprivate _type = "launcher";
params ["_man", "_battleField", "_type"];
private _searchRadius  = selectMax [60, SFSM_DodgeDistance];
private _unitPos       = getPos _man;
private _weapons       = missionNamespace getVariable (_battlefield get "weapons");
        _weapons       = _weapons inAreaArray [_unitPos, _searchRadius, _searchRadius];

if(_weapons isEqualTo [])exitWith{};

private _units         = missionNamespace getVariable (_battleField get "units");
private _destinations  = [];
private _weaponClasses = [];
private _usableWeapons = [];



if(_type == "launcher")then{_weaponClasses = [4, 4.01, 4.1, 4.3, 4.4]};

{
	private _weapon = _X;
	if((!isNil "_weapon"))
	then{
			private _weaponName      =  getWeaponCargo _X#0#0;
			private _weaponData      = createHashmap;

			if(!isNil "_weaponName")
			then{
					_weaponData = [_weaponName] call objScan_fnc_weaponData;
			private _weaponClass     = _weaponData get "class ID";
			private _weaponOwner     = _weapon getVariable "SFSM_newOwner";
			private _correctType     = _weaponClass in _weaponClasses;
			private _weaponAvailable = (isNil "_weaponOwner");
			if!(_weaponAvailable)then{_weaponAvailable = (!alive _weaponOwner)};
			

			if(_weaponAvailable
			&&{_correctType
			&&{!isNull _weapon}})
			then{_usableWeapons pushBack _weapon};

		}};

} forEach _weapons;

if(_usableWeapons isEqualTo [])exitWith{};

private _selectedWeapon = [_man, _usableWeapons] call Tcore_fnc_nearestPos;

_selectedWeapon;params ["_man"];
private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
// if(_battleKey == "none")exitWith{};
private _battleField    = SFSM_battles get _battleKey;
if(isNil '_battleField')exitWith{};
_battleFieldparams["_positions"];
private _excluded = [];

{
	private _nearest = [_x, _positions] call Tcore_fnc_nearestPos;
	if(_nearest distance2D _x < 1.2
	&&{!(_nearest isEqualTo _x)})
	then{_excluded pushBackUnique _x};
} forEach _positions;

systemChat (["posEqual =", (_excluded isEqualTo _positions)]joinString"");

_excluded;params["_man", "_success", "_weapon"];
private _statusText = "failed picking up weapon";

if(_success)
then{_statusText = "Picked up weapon successFully!"};

[_man, "action", _statusText] call SFSM_fnc_unitData;
_man setAnimSpeedCoef 1;
sleep 1;
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
_man doMove (getPos _man);
_man doFollow (leader (group _man));

if((!isNil "_weapon")
&&{!isNull _weapon})
then{_weaponObject setVariable ["SFSM_newOwner", nil]}params ["_man"];

if!(SFSM_emergencyRearm)exitWith{false};

private _battleKey   = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battleField =  SFSM_Battles get _battleKey;

if(isNil "_battleField")exitWith{false};

private _launcher = secondaryWeapon _man;
if!(_launcher == "")exitWith{};

private _weapon     = [_man, _battleField] call SFSM_fnc_getBattlefieldWeapon;

if(isNil "_weapon")exitWith{false};

[_man, _weapon] spawn SFSM_fnc_pickUpWeapon;

true;Params["_clusterData", "_mapObjects", "_clusterPositions"];

private _clusterPos   = _clusterData#0;
private _size         = _clusterData#2;
private _side         = _clusterData#3;
private _searchRadius = (selectMax[_size, SFSM_DodgeDistance]);
private _objectPositions = _mapObjects get "positions";
private _nearObjPos = _objectPositions inAreaArray [_clusterPos, _searchRadius, _searchRadius];
private _coverPositions = [];

private _enemyPosArr = (_clusterPositions get "east") + (_clusterPositions get "independent");

if(_side == east)       then{_enemyPosArr = (_clusterPositions get "west") + (_clusterPositions get "independent")};
if(_side == independent)then{_enemyPosArr = (_clusterPositions get "east") + (_clusterPositions get "west")};

{
	private _key = str _X;
	private _objectShape = (_mapObjects get _key) get "3dData";
	private _coverPosArr = [_enemyPosArr, _objectShape] call Tcore_fnc_objCoverPosLight;
	private _coverPos    = _coverPosArr#0;
	private _nearestPos  = [_coverPos, _coverPositions] call Tcore_fnc_nearestPos; 
	private _found       = !(typeName _nearestPos == "SCALAR");
	private _distance    = 3;

	if(_found)then{_distance = (_coverPos distance2D _nearestPos)};

	if(_distance > 1.2)
	then{_coverPositions pushback _coverPos};	

} forEach _nearObjPos;

 
[_side, _coverPositions]params ["_unit"];
if!([_unit] call SFSM_fnc_isRealMan)exitWith{false;};

private _lastBullet = [_unit, "last_bullet_fired"] call SFSM_fnc_unitData;
if(time - _lastBullet < 2)exitwith{false};

private _battle = [_unit, "currentBattle"] call SFSM_fnc_unitData;
if!(_battle == "none")exitwith{false};

private _lastBattle = [_unit, "lastBattle"] call SFSM_fnc_unitData;
if(time - _lastBattle < 10)exitwith{false};

private _target = getAttackTarget _unit;
if(isNull _target)exitwith{false};
if!([_target] call SFSM_fnc_isRealMan)exitWith{false;};

private _initData = [_unit, _target] call SFSM_fnc_battleInitType;
if!(_initData#0 == "start")exitwith{false};


true;params ["_unit", "_target"];
if!([_unit] call SFSM_fnc_isRealMan)exitWith{false};
if!([_target] call SFSM_fnc_isRealMan)exitWith{false};
private _lastBullet = [_unit, "last_bullet_fired"] call SFSM_fnc_unitData;
if(time - _lastBullet < 2)exitwith{false};

private _battle = [_unit, "currentBattle"] call SFSM_fnc_unitData;
if!(_battle == "none")exitwith{false};

private _lastBattle = [_unit, "lastBattle"] call SFSM_fnc_unitData;
if(time - _lastBattle < 10)exitwith{false};

private _initData = [_unit, _target] call SFSM_fnc_battleInitType;
if!(_initData#0 == "start")exitwith{false};


true;params["_man", "_weaponObject"];

private _canPickUp =
((!isNil "_man")
&& {(!isNil "_weaponObject")
&& {(!isNull _weaponObject)
&& {alive _man}}});

_canPickUp;params["_battleField"];
private _pos    = (_battleField get "center");
private _radius = (_battleField get "radius");
private _units  = missionNamespace getVariable (_battleField get "units");
private _unitsFighting = [];

{
	private _target = getAttackTarget _x;
	if(!isNull _target
	&&{(_target distance2D _pos) < _radius})
	then{
			_unitsFighting pushBack _x;
		};
} forEach _units;

_unitsFightingparams["_unitA", "_unitB"];
if!([_unitA] call SFSM_fnc_isRealMan)exitWith{[("logic detected" call dbgmsg), ""]};
if!([_unitB] call SFSM_fnc_isRealMan)exitWith{[("logic detected" call dbgmsg), ""]};

private _posA          = (getPos _unitA);
private _posB          = (getPos _unitB);
private _midPos        = [_posA, _posB] call Tcore_fnc_getMidpoint;
private _nearestBattle = [_midPos] call SFSM_fnc_nearestBattle;

if!(typeName _nearestBattle == "HASHMAP")
exitWith{["start", ""]};

private _battlePos    = _nearestBattle     get "center";
private _battleKey    = str(_nearestBattle get "center");
private _battleRadius = _nearestBattle     get "radius";
private _distanceA    = _posA distance2D _battlePos;
private _distanceB    = _posB distance2D _battlePos;
private _distToBattle = _midPos distance2D _battlePos;


private _insideBattle = ((_distanceA < _battleRadius
					  &&{_distanceB < _battleRadius})
					  || _distToBattle < _battleRadius);

if(_insideBattle)exitWith{["join", _battleKey]};


private _AtoB            = (_posA distance2D _posB);
private _thisRadius      = (_AtoB / 2);
private _combinedRadius  = _battleRadius + _thisRadius;

private _maxDistance     = round(selectMax[_distToBattle, _distanceA, _distanceB]);
private _expand          = (_combinedRadius > _distToBattle);

private _addedRadius     = (_maxDistance - _battleRadius);

if(_expand)exitWith{["expand", _battleKey, _addedRadius]};

["start", ""];params[
		"_battlefield", 
		"_clustersData", 
		"_weapons",
		"_units",
		"_deadMen",
		"_vehicles", 
		"_groups", 
		"_areaName", 
		"_mapObjsData"
	];

private _mapObjVarName   = [_areaName, "Battle_", "_mapObjects"]call Tcore_fnc_stringToVarName;
private _weaponsVarName  = [_areaName, "Battle_", "_weapons"]   call Tcore_fnc_stringToVarName;
private _unitsVarName    = [_areaName, "Battle_", "_Units"] 	call Tcore_fnc_stringToVarName;
private _deadMenVarName  = [_areaName, "Battle_", "deadMen"] 	call Tcore_fnc_stringToVarName;
private _VehiclesVarName = [_areaName, "Battle_", "_Vehicles"] 	call Tcore_fnc_stringToVarName;
private _ClustersVarName = [_areaName, "Battle_", "_Clusters"] 	call Tcore_fnc_stringToVarName;
private _groupsVarName   = [_areaName, "Battle_", "_Groups"] 	call Tcore_fnc_stringToVarName;

missionNamespace setVariable [_mapObjVarName,   _mapObjsData];
missionNamespace setVariable [_weaponsVarName,   _weapons];
missionNamespace setVariable [_unitsVarName,    _units];
missionNamespace setVariable [_deadMenVarName,  _deadMen];
missionNamespace setVariable [_VehiclesVarName, _vehicles];
missionNamespace setVariable [_ClustersVarName, _clustersData];
missionNamespace setVariable [_groupsVarName,   _groups];

_battlefield set ["mapObjects",     _mapObjVarName];
_battlefield set ["weapons",        _weaponsVarName];
_battlefield set ["units", 			_unitsVarName];
_battlefield set ["deadMen",		_deadMenVarName];
_battlefield set ["vehicles", 		_VehiclesVarName];
_battlefield set ["clusterData",	_ClustersVarName]; 
_battlefield set ["groups",	        _groupsVarName];

[_units, _groups]params ['_battleField'];
// sleep SFSM_BattleUpdateSec;

while {!isNil "_battleField"} 
do 	{
		
		

		private _ended = [_battleField] call SFSM_fnc_updateBattlefield;
		if(isNil "_ended")exitWith{};
		if(_ended)exitWith{};

		private _script = [_battleField] spawn SFSM_fnc_updateGrid;
		waitUntil {
			private _finito = scriptDone _script;
			if(isNil "_finito")exitWith{true;};
			_finito; 
		};

		// private _script = [_battleField] spawn SFSM_fnc_assignAllBuildings;
		// waitUntil {scriptDone _script};

		private _script = [_battleField] spawn SFSM_fnc_battleFieldCQB;
		waitUntil {
			private _finito = scriptDone _script;
			if(isNil "_finito")exitWith{true;};
			_finito; 
		};

		_battlefield set ["currentAction",	"Assigning vehicles"];
		private _script = [_battleField] spawn SFSM_fnc_hijackAllVehicles;
		waitUntil {
			private _finito = scriptDone _script;
			if(isNil "_finito")exitWith{true;};
			_finito; 
		};
		_battlefield set ["currentAction",	"none"];

		
		_battlefield set ["currentAction",	"Reinforcing vehicles"];
		private _script = [_battleField] spawn SFSM_fnc_reinforceVehicles;
		waitUntil {
			private _finito = scriptDone _script;
			if(isNil "_finito")exitWith{true;};
			_finito; 
		};
		_battlefield set ["currentAction",	"none"];

		sleep SFSM_BattleUpdateSec;
	};

true;params["_pos", '_baseRadius'];
private _returnRadius = _baseRadius;
private _checkRadius  = _baseRadius*2;
if(_checkRadius < 300)then{_checkRadius = 300};
private _units        = _pos nearEntities ['CAManBase', _checkRadius];
private _filter = {
	([_x] call SFSM_fnc_isRealMan
	&&{(side _x) in [east,west,independent]
	&&{([_x, "currentBattle"] call SFSM_fnc_unitData) == "none"}})
	};

_units = _units select _filter;
private _maxRadius    = [_pos, _units] call Tcore_fnc_clusterSize;

_maxRadius = _maxRadius*1.25;

if(_maxRadius > _baseRadius)then{_returnRadius = _maxRadius};

_returnRadius;params["_battlefield"];

//wait for grid to load, so that actions like hiding may be properly executed
private _timer = time +5;
waitUntil
{
	sleep 0.1;
	private _gridLoaded = (_battlefield get "gridLoaded");
	if(isNil "_gridLoaded")	exitWith{true};
	if(_gridLoaded)			exitWith{true};
	if(_timer > time)		exitWith{true};
	false;
};

private _vehicles = missionNamespace getVariable (_battlefield get "vehicles");
{[_x] call SFSM_fnc_updateVehicle;}forEach _vehicles;
//loop through all units in the battle assigning start-battle actions.

private _units = missionNamespace getVariable (_battlefield get "units");
{
	private _group          = group _x;
	private _specialActions = [_x, _battlefield] call SFSM_fnc_specialInitFightActions;
	private _grpCanDodge    = ([_group] call SFSM_fnc_groupCanDodge);
	private _excluded       = _x getVariable ["SFSM_Excluded",false];
	if(_grpCanDodge
	&&{(! _specialActions)
	&&{! _excluded}})
	then{
			private _reacting = [_x, _battleField] call SFSM_fnc_reactToVehicles;
			if!(_reacting)then{ [_x, _battlefield] call SFSM_fnc_fightInitCover};
		};

} forEach _units;


//wait for the battlefield framework to register all map-objects in the area
waitUntil
{
	sleep 0.5;
	private _terrainLoaded = (_battlefield get "terrainLoaded");
	if(isNil "_terrainLoaded")	exitWith{true};
	if(_terrainLoaded)			exitWith{true};
	false;
};

//update cover-positions
_battlefield set ["currentAction",	"Loading cover positions"];
[_battlefield] call SFSM_fnc_getCoverPositionsLight;

private _loadingTime = time - (_battlefield get "Started");

[["Terrain and coverPositions finished loading in ", _loadingTime, " seconds"]] call SFSM_fnc_debugMessage; 

_battlefield set ["currentAction",	"none"];

//spawn a loop that updates the battlefield-hashmap every 10 seconds(can be changed in init-server)
[_battlefield] spawn SFSM_fnc_battleFieldUpdater;

true;params["_battleKey"];
private _battlefield   = SFSM_Battles get _battleKey;
if(isNil "_battlefield")exitWith{"BattleField not found" call SFSM_fnc_debugMessage};
private _markers         = _battlefield get "markers";
private _gridVar         = _battlefield get "grid";
private _unitVar         = _battlefield get "units";
private _deadVar         = _battlefield get "deadMen";
private _vehicleVar      = _battlefield get "vehicles";
private _mapObjVarName   = _battlefield get "mapObjects";
private _weaponsVarName  = _battlefield get "weapons";
private _groupsVarName   = _battlefield get "groups";
private _ClustersVarName = _battlefield get "clusterData";
private _hunkObjVarName  = _battlefield get "hunkerObjects";
private _buildingsVarName= _battlefield get "buildings";


private _vehicles= missionNamespace getVariable _vehicleVar;
private _units   = missionNamespace getVariable _unitVar;
private _groups  = missionNamespace getVariable _groupsVarName;
private _endText = ["Battle ", (_battlefield get "name"), " ended."] joinString "";


{
	private _currentBuilding = [_x, "currentBuilding"] call SFSM_fnc_unitData;
	private _pathEnabeled = [_x, "pathEnabeled"] call SFSM_fnc_unitData;
	if!(_currentBuilding == "none")
	then{
          missionNamespace setVariable [_currentBuilding, nil, true];
          [_x, "currentBuilding", "none"] call SFSM_fnc_unitData;
	};


	[_x, "currentBattle", "none"] call SFSM_fnc_unitData;
	[_x, "lastBattle", time]      call SFSM_fnc_unitData;
	if(_pathEnabeled)then{_x enableAI "all";};
	_x setUnitPos "AUTO";
	_x doFollow leader (group _x);
}  forEach _units;

{[_x, "currentBattle", "none"] call SFSM_fnc_groupData;} forEach _groups;
{[_x, "currentBattle", "none"] call SFSM_fnc_vehicleData;} forEach _vehicles;
{deleteMarker _x} forEach _markers;

missionNamespace setVariable [_gridVar,         nil, true];
missionNamespace setVariable [_unitVar,         nil, true];
missionNamespace setVariable [_deadVar,         nil, true];
missionNamespace setVariable [_vehicleVar,      nil, true];
missionNamespace setVariable [_mapObjVarName,   nil, true];
missionNamespace setVariable [_groupsVarName,   nil, true];
missionNamespace setVariable [_weaponsVarName,  nil, true];
missionNamespace setVariable [_ClustersVarName, nil, true];
missionNamespace setVariable [_hunkObjVarName,  nil, true];
missionNamespace setVariable [_buildingsVarName,nil, true];

{_battlefield deleteAt _X}forEach _battlefield;

SFSM_Battles deleteAt _battleKey;
_battlefield = nil;

_endText call SFSM_fnc_debugMessage;

_endText;params ["_battleField"];

_battlefield set ["currentAction",	"Assigning CQB"];
private _units = missionNamespace getVariable (_battleField get "units");

{
  private _script = [_x] spawn SFSM_fnc_initCQB;
  waitUntil{sleep 0.02; scriptDone _script};
  
} forEach _units;
_battlefield set ["currentAction",	"none"];
true;params ['_battleField'];
private _timePassed = time - (_battlefield get "Started");
private _name       = _battlefield get 'name';

//Do not enda a battle if it just started.
if(_timePassed < 60)exitwith{false};

//end the battle if there is only 1 side left.
private  _sides = (_battlefield get "sides") call SFSM_fnc_sidesFromString;
if(count _sides < 2)
exitWith{
			[[str (_sides#0), ' Has won battle at ', _name, '!']] call dbgmsg;
			true;
		};


//Get the last unit who fired his weapon, and measure the time since he shot.
private _units = missionNamespace getVariable (_battleField get 'units');
_units = ([_units, [], { [_x, "last_bullet_fired"] call SFSM_fnc_unitData;}, "ASCEND"] call BIS_fnc_sortBy);
private _lastToShoot = _units#(count _units-1);
private _lastGunshot = [_lastToShoot, "last_bullet_fired"] call SFSM_fnc_unitData;
private _lastShotTime = time - _lastGunshot;


//End the battle if there are less than 2 units engaged and over 120s since last shot.
private  _unitsFighting = [_battleField] call SFSM_fnc_battlingUnits;
if(count _unitsFighting < 2
&&{_lastShotTime > 120})
exitWith{
			[['Ending battle at ', _name, '. ', _lastShotTime, ' Seconds since last shot']] call dbgmsg;
			true;
		}; 

false;params ["_man"];
sleep 1;
private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield = SFSM_Battles get _battleKey;

if(isNil "_battlefield")exitWith{};

private _droppedWeapons = nearestObjects [_man, ["WeaponHolder", "WeaponHolderSimulated"], 5];

private _weaponCount    = count _droppedWeapons;

if(_weaponCount == 0)exitWith{["could not find weapons close to dead man", 2] call dbgmsg};

private _weaponsVar = (_battlefield get "weapons");

{
	(missionNamespace getVariable _weaponsVar) pushBackUnique _X;
	_x setVariable ["SFSM_weaponOwner", _man];
} forEach _droppedWeapons;



private _finalCount = count (missionNamespace getVariable _weaponsVar);

[[
	_weaponCount, 
	" weapons were added to battlefield-data. ",
	_finalCount,
	" weapons cached"
]] call dbgmsg;



true;