//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


// Description:   This function will initialize a battlefield, and store all the data in a hashmap.

// params: _unitA (object), _unitB (object)

// returnValue: battleKey (string)- the key used to access the battlefield hashmap in the SFSM_Battles hashmap.

//Example: ["unit1", "unit2"] call SFSM_fnc_initBattlefield;

//_unitA && _unitB refers to the two units who first spot eachother.
params ["_unitA", "_unitB"];

"Initializing battle." call SFSM_fnc_debugMessage;
private _battlefield = createHashmap;
private _startTime   = time;
private _dimensions  = [_unitA, _unitB] call SFSM_fnc_battlefieldDimensions;
private _centerPos   = _dimensions#0;
private _radius      = _dimensions#1;
private _battleKey   = (str _centerPos);
private _sides       = [east, west, independent];
private _markers     = [];
private _supplies    = _centerPos nearSupplies _radius;

if(!isNil "SQFM_fnc_posRadInitBattle")
then{
	private _battleMap = [_centerPos, _radius] call SQFM_fnc_posRadInitBattle;
	_battlefield set ["SQFM_battleMap", _battleMap];
	"SQFM battlemap initialized" call dbgmsg;
};

_battlefield set ["currentAction",  "initializing"];
_battlefield set ["center",         _centerPos];
_battlefield set ["markers",        _markers];
_battlefield set ["Started",         _startTime];
_battlefield set ["lastDataUpdate", -300];
_battlefield set ["lastGunshot",    -300];
_battlefield set ["radius",         _radius];
_battlefield set ["gridLoaded",     false];
_battlefield set ["terrainLoaded",  false];

SFSM_Battles set [_battleKey, _battlefield];

private _clustersData = [
                            _centerPos,    // center of area
                            _sides,     // sides
                            true,        // return all data
                            _radius,    // AreaRadius
                            50,            // ClusterRadius
                            2,            // height of returned positions (AGL)
                            false        // include terrainObjects
                        ] call Tcore_fnc_allClustersInRadius;

[["Loaded clusterPositions in ",(time - _startTime)," seconds."]] call SFSM_fnc_debugMessage;
// if(true) exitWith {};

private _mapObjsData = createHashmap;

//the following function will get all the info on the map-objects in the area.
//it will get the objects inside the cluster-zones using a unscheduled call
//then it will use a scheduled call (spawn) to aquire all of the map-objects within the battlefield radius.
//This might take some time depending on the amount of objects in the area.
[_centerPos, _radius, _battlefield, _clustersData, _mapObjsData, true] call SFSM_fnc_areaData; 

private _unitFilter = {

    private _action = [_x, "action"] call SFSM_fnc_unitData;

    (!(_x getVariable ["SFSM_Excluded",false]))
    &&{(typeOf _x) == (typeOf (vehicle _x))
    &&{!isNil "_action"}}

    };

private _groups   = [_clustersData]       call Tcore_fnc_clusterGroups;
private _units    = ([_clustersData]      call Tcore_fnc_clusterUnits) select _unitFilter;
private _vehicles = [_clustersData]       call Tcore_fnc_clusterVehicles;
private _deadMen  = [_centerPos, _radius] call Tcore_fnc_deadMenInArea;
private _weapons  = nearestObjects [_centerPos, ["WeaponHolder", "WeaponHolderSimulated"], _radius];
private _areaName = _battlefield get "name";

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
    _mapObjsData,
    _supplies
] call SFSM_fnc_battlefieldVariables;

_battlefield set ["zones", ([_battlefield] call SFSM_fnc_getZones)];

{[_x, "currentBattle", _battleKey] call SFSM_fnc_vehicleData;} forEach _vehicles;
{[_x, "currentBattle", _battleKey] call SFSM_fnc_unitData}     forEach _units;
{[_x, "currentBattle", _battleKey] call SFSM_fnc_groupData}    forEach _groups; 


//initGrid will create a hashmap containing 100 positions, and 3 arrays containing positions hidden from clusters divided by side.
[_battlefield] spawn SFSM_fnc_initGrid;

//Records the house a soldier is inside, in said units hashmap.
// [_battleField] spawn SFSM_fnc_assignAllBuildings;


if(SFSM_simpleBff isEqualTo false)then{[_battlefield] call SFSM_fnc_getCoverPositionsLight;};

[["Battle at ", _areaName, " initialized in ", (time - _startTime), " seconds"]] call SFSM_fnc_debugMessage;

_battlefield set ["currentAction", "loading terrain"];
[_battlefield] call SFSM_fnc_bfDebugMarkers;
[_battlefield] spawn SFSM_fnc_battlefieldPostInit;

["new_battle", [_battlefield]] call CBA_fnc_localEvent;

_battleKey; 