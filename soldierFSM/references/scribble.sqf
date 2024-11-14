Tally_fnc_ZoneFillers = {
params ["_center", "_radius", "_subZones", "_cornerRadius"];

private _midDist   = _radius * 0.55;
private _midRad    = _cornerRadius * 0.42;
private _shortDist   = _radius * 0.29;
private _shortRad   = _cornerRadius * 0.43;

private _longDist   = _radius * 0.898;
private _longRad    = _cornerRad * 0.59;


if(_shortRad < 10)exitWith{_subZones};

private _zoneFillers = [];
private _directions  = [45, 
                        135, 
                        225, 
                        315];

{
    private _midPos   = [_center # 0, _center # 1, _x,_midDist] call Tcore_fnc_sinCosPos;
    private _shortPos = [_center # 0, _center # 1, _x,_shortDist] call Tcore_fnc_sinCosPos;
    private _longPos  = [_center # 0, _center # 1, (_x -17.5),_longDist] call Tcore_fnc_sinCosPos;
    private _longPos2  = [_center # 0, _center # 1, (_x +17.5),_longDist] call Tcore_fnc_sinCosPos;
    
    private _midZone   = [_midPos, _midRad];
    private _shortZone = [_shortPos, _shortRad];
    private _longZone  = [_longPos, _longRad];
    private _longZone2  = [_longPos2, _longRad];

    private _newZones = [_midZone, _shortZone, _longZone, _longZone2];

    _zoneFillers = [_newZones, _zoneFillers] call Tcore_fnc_toArrFromArr;

} forEach _directions;

_subZones = [_zoneFillers, _subZones] call Tcore_fnc_toArrFromArr;

_subZones};


Tally_Fnc_splitZone = { 
private _maxRadius     = 200;
private _includeParent = false;
private _drawZone      = false;
params ["_center", "_radius", "_maxRadius", "_includeParent", "_drawZone"];
private _map = createHashmap;
private _parentZone = [_center, _radius];
private _subZones   = [];
private _finalArr   = [];


if(_radius > _maxRadius)then{
private _Rad         = _radius * 0.415;
private _distance     = _radius * 0.585;

private _cornerDist = _distance * 1.415;
private _cornerRad  = _Rad * 0.41;

private _midDist1   = _radius * 0.898;
private _midRad1    = _cornerRad * 0.59;

private _northPos = [_center # 0, _center # 1, 0,   _distance] call Tcore_fnc_sinCosPos;
private _eastPos  = [_center # 0, _center # 1, 90,  _distance] call Tcore_fnc_sinCosPos;
private _southPos = [_center # 0, _center # 1, 180, _distance] call Tcore_fnc_sinCosPos;
private _westPos  = [_center # 0, _center # 1, 270, _distance] call Tcore_fnc_sinCosPos;



private _northEastPos = [_center # 0, _center # 1, 45,  _cornerDist] call Tcore_fnc_sinCosPos;
private _southEastPos = [_center # 0, _center # 1, 135, _cornerDist] call Tcore_fnc_sinCosPos;
private _southWestPos = [_center # 0, _center # 1, 225, _cornerDist] call Tcore_fnc_sinCosPos;
private _northWestPos = [_center # 0, _center # 1, 315, _cornerDist] call Tcore_fnc_sinCosPos;

private _northEastPos1 = [_center # 0, _center # 1, 27.5,  _midDist1] call Tcore_fnc_sinCosPos;

private _bigZones = [
                        [_northPos, _Rad],
                        [_eastPos,  _Rad],
                        [_southPos, _Rad],
                        [_westPos,  _Rad]
                    ];

_subZones   =  [
                    [_northEastPos, _cornerRad],
                    [_southEastPos, _cornerRad],
                    [_southWestPos, _cornerRad],
                    [_northWestPos, _cornerRad],
                    [_center,       _cornerRad]
                ];




 if(_Rad <= _maxRadius)then{{_subZones pushBack _x} forEach _bigZones}
else{_subZones = [_center, _radius, _subZones, _cornerRad] call Tally_fnc_ZoneFillers};

if(_cornerRad > _maxRadius)
then{
        {
            private _zones = _x call Tally_Fnc_splitZone;
            _finalArr      = [_zones, _finalArr] call Tcore_fnc_toArrFromArr;
        } forEach _subZones;
    }
else{
        _finalArr      = [_subZones, _finalArr] call Tcore_fnc_toArrFromArr;
    };


if(_Rad > _maxRadius)
then{
        {
            private _zones = _x call Tally_Fnc_splitZone;
            _finalArr      = [_zones, _finalArr] call Tcore_fnc_toArrFromArr;
        } forEach _bigZones;
    };

};

if(_includeParent)    then{_finalArr pushBackUnique _parentZone};
if(_drawZone)        then{{_x call SFSM_fnc_drawCircle} forEach _finalArr};


_finalArr};

SFSM_fnc_avgPosASL = { 
params["_posArr"];
if(count _posArr == 0)exitWith{[]};
if(count _posArr < 2)exitWith{_posArr#0};

Private _Xarr             = [];
Private _Yarr             = [];
Private _Zarr             = [];

{
    _Xarr pushback _x#0;
    _Yarr pushback _x#1;
	_Zarr pushback _x#2;
} forEach _posArr;

private _XX = [_Xarr] call Tcore_fnc_average;
private _YY = [_Yarr] call Tcore_fnc_average;
private _ZZ = [_Zarr] call Tcore_fnc_average;

[_XX, _YY, _ZZ];
};

SFSM_fnc_posDiff = { 
params["_pos1", "_pos2"];
private _diff = [
    (_pos2#0) - (_pos1#0),
    (_pos2#1) - (_pos1#1),
    (_pos2#2) - (_pos1#2)
    ];

_diff;
};

SFSM_fnc_guideRPG = { 
params [
	"_man", 
	"_weapon", 
	"_muzzle", 
	"_mode", 
	"_ammo", 
	"_magazine", 
	"_missile", 
	"_vehicle"
];

private _target = (_man getVariable ["SFSM_missileTarget",objNull]);
if(isNull _target)exitWith{"No target for missile" call dbgMsg;};
sleep 0.1;

private _targetASL  = [_target] call SFSM_fnc_buildingCenterPosASL;
private _velocityMS = velocityModelSpace _missile;

//Repeat it twice just to make sure it actually sticks.
for "_i" from 0 to 1 do {
if(isNull _missile)exitWith{};

[_missile, _targetASL] call SFSM_fnc_setDirAndPitchToPos;
_missile setVelocityModelSpace _velocityMS;

sleep 0.1;
};


true;
};

SFSM_fnc_sortAnimsByTargetDist = { 
params ["_animMaps", "_targetDist"];
private _sortingAlgo = {
	private _animDistance = _y get "distance";
	private _diff = [_animDistance, _targetDist] call SFSM_fnc_numberDiff;

	_diff;
};

private _maps = [_animMaps, [], _sortingAlgo, "ASCEND"] call BIS_fnc_sortBy;

_maps;
};

SFSM_fnc_initAnimTracking = { 
params["_man"];
private _pos = getPosATLVisual _man;
_man setVariable ["sprintAnimStart",     _pos];
_man setVariable ["sprintAnimPositions", [_pos]];
_man setVariable ["sprintAnimDistances", []];

true;
};

SFSM_fnc_endAnimTracking = { 
params["_man"];
_man setVariable ["sprintAnimStart",     nil];
_man setVariable ["sprintAnimPositions", nil];
_man setVariable ["sprintAnimDistances", nil];

true;
};

SFSM_fnc_trackAnimDistance = { 
params["_man"];
(_man getVariable "SFSM_animListParams")
params [
	"_animArr", 
	"_waitForCompletion", 
	"_condition", 
	"_midFnc", 
	"_postFnc", 
	"_index", 
	"_startTime", 
	"_timer", 
	"_eh"
];


private _pos       = getPosATLVisual _man;
private _lastPos   = _man getVariable "sprintAnimStart";
SFSM_Custom3Dpositions = missionNamespace getVariable ["SFSM_Custom3Dpositions", []];

if(isNil "_lastPos")exitWith{[_man] call SFSM_fnc_initAnimTracking;};

private _distance = (getPosATLVisual _man) distance _lastPos;

[[_distance], 2] call dbgmsg;

(_man getVariable "sprintAnimDistances") pushBack _distance;
(_man getVariable "sprintAnimPositions") pushBack _pos;

private _allPoss   = _man getVariable "sprintAnimPositions";
private _distances = _man getVariable "sprintAnimDistances";

for "_i" from 0 to (count _allPoss-1) do 
{ 
	private _pos  = _allPoss#_i;
	private _text = "start";
	if(_i > 0)then{_text = str (_distances#(_i-1)) };
	SFSM_Custom3Dpositions pushBack [_pos, _text];
};
private _avg = [_distances, true] call Tcore_fnc_average;


_man setVariable ["sprintAnimStart", (getPosATLVisual _man)];

if(_index isEqualTo ((count _animArr)-3)) exitWith{
	[["Average distance = ", _avg], 2] call dbgmsg;
	[_man] call SFSM_fnc_endAnimTracking;
};
};

["BFF_overRun", {
params["_orMen"];

// private _dbgMn = (_orMen#0);
// [_dbgMn] spawn dbg_cam;

}] call CBA_fnc_addEventHandler;

["pre_bomb_on_capture", {
params["_man", "_captor"];

[_man] spawn dbg_cam;

}] call CBA_fnc_addEventHandler;

["new_unitData", {
params["_man", "_dataEntry", "_prevValue", "_newValue"];
if(_dataEntry isNotEqualTo "action")exitWith{};

private _valArr = _man getVariable ["SFSM_allActions",[]];
private _flashAction = [_man, "flashAction"] call SFSM_fnc_unitData;

_valArr pushBack ["Action-change", _prevValue, _newValue, time];
_man setVariable ["SFSM_allActions", _valArr];

if ((_prevValue isEqualTo "!PANIC!" || {_prevValue isEqualTo "Surrendered"})
&& {_newValue isEqualTo "none"}) then {
    [_man] spawn dbg_cam;
};

}] call CBA_fnc_addEventHandler;

// {
//     _x addEventHandler ["Fleeing", {
//         params ["_group", "_fleeingNow"];
//         if(_fleeingNow)then{[_group] call SFSM_fnc_analizeFleeing;};    
//     }]; 

// } forEach allGroups;



["brain_reset", {
params["_man"];
private _action      = [_man] call SFSM_fnc_getAction;
private _flashAction = [_man, "flashAction"] call SFSM_fnc_unitData;
private _valArr      = _man getVariable ["SFSM_allActions",[]];

_valArr pushBack ["Brain-Reset", _action, _flashAction, time];

_man setVariable ["SFSM_allActions", _valArr];

}] call CBA_fnc_addEventHandler;


["flash_action", {
params["_man", "_flashAction"];
private _action      = [_man] call SFSM_fnc_getAction;
private _valArr      = _man getVariable ["SFSM_allActions",[]];

_valArr pushBack ["Flash-action", _flashAction, _action, time];

_man setVariable ["SFSM_allActions", _valArr];

}] call CBA_fnc_addEventHandler;


["sprint_start", {
params["_man", "_destination"];
private _valArr      = _man getVariable ["SFSM_allActions",[]];
private _action      = [_man] call SFSM_fnc_getAction;

_valArr pushBack ["Sprint-Start", _action, _destination, time];

_man setVariable ["SFSM_allActions", _valArr];

}] call CBA_fnc_addEventHandler;


["sprint_end", {
params["_man", "_destination"];
private _valArr      = _man getVariable ["SFSM_allActions",[]];
private _action      = [_man] call SFSM_fnc_getAction;

_valArr pushBack ["Sprint-End", _action, _destination, time];

_man setVariable ["SFSM_allActions", _valArr];

}] call CBA_fnc_addEventHandler;




// (group player) addEventHandler ["CommandChanged", {_this call SFSM_fnc_onCommandChange;}];


SFSM_fnc_getActiveScripts = { 
params[["_copy", false], ["_namesOnly"]];

private _scriptData   = diag_activeSQFScripts apply {[_x#0, _x#3]};
private _scriptCount1 = diag_activeScripts#0;
private _scriptCount2 = count _scriptData;

private _outPut = [[_scriptCount1, _scriptCount2], _scriptData];

if(_copy)then{
	copyToClipboard str _outPut;
	hint str _outPut;
};

_outPut;
};


SFSM_fnc_analizeFleeing = { 
params["_group"];
private _data = [];

{
	private _class  = "soldier";
	if(_x isEqualTo leader _group)then{_class = "Leader"};
	private _morale = [_x, "morale"] call SFSM_fnc_unitData;
	private _fleeCoef = [_x, "fleeCoef"] call SFSM_fnc_unitData;
	_data pushback [_class, _morale, _fleeCoef];
} forEach units _group;

copyToClipboard str _data;
[(units _group)#0] spawn dbg_cam;
hint "Flee-data copied!";
};

SFSM_fnc_getAllVarsArr = { 
params["_man"];
private _title   = ["|***|- ALL VARIABLES FOR ", (toUpper name _man), "AT ",(time)," seconds", " -|***|"]joinString"";
private _allvars = [_title];

{
	private _val = (_man getVariable [_x, ""]);
    if(typeName _val == "object")then{_val = str _val;};
	if("ace_" in _x isEqualTo false
	&&{"cba_" in _x isEqualTo false})
	then{_allvars pushBack [_x, _val];};
	
	
} forEach (allVariables _man);

_allvars;
};


SFSM_customExpression = "";

[] spawn { 
while {sleep 0.1; true;} do {
    if(SFSM_customExpression isNotEqualTo "")then{
        private _value = call compile SFSM_customExpression;
        if(isNil "_value")then{_value = "Value is nil"};
        if(typeName _value isEqualTo "STRING")then{hintSilent _value}
        else{
            if(typeName _value isEqualTo "TEXT")then{hintSilent _value}
            else{hintSilent str _value;};
            
        };
        };
    };
};

SFSM_fnc_debugCuratorKeyHandler = { 
params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
private _pressed = false;

if(_key isEqualTo 79)exitWith {execVM 'devFile.sqf'; true;};

if   (_ctrl 
&&   {_key isEqualTo 34})
exitWith{
        [] call SFSM_fnc_onDbgCurKey;
        true;
};

false;
};

SFSM_fnc_activeFunctions = {
    (diag_activeSQFScripts select {"SFSM_fnc_" in (_x#0)})apply {_x#0};
};