// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_impactPos", "_ammoType"];
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

SFSM_lastCrater = time;