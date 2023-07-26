//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_pos", "_areaName", "_radius"];
/*
In some situations the standard scanner takes over 3 minutes to process
every single map-object in the area. 
In these situations It is unfortunately necesary to reduce the amount of objects.
This will lead to fewer cover-positions, and the exclusion of some very good cover-objects,
but will allow the battle to initialize at a proper speed.

The situations that require a reduced amount of objects are:
1) In urban areas
2) Everywhere on Tanoa
3) Near WineYards.
4) SOG DLC maps.
*/

if(worldName isEqualTo "Tanoa")       exitWith{true};
if(worldName isEqualTo "Cam_Lao_Nam") exitWith{true};
if(worldName isEqualTo "vn_khe_sanh") exitWith{true};
if(worldName isEqualTo "vn_the_bra")  exitWith{true};

private _inUrbanArea = (count (_areaName splitString " ")) isEqualTo 1;
if(_inUrbanArea)exitWith{true};


private _distToWineYard = _pos distance2d getPos (nearestLocation [_pos, "VegetationVineyard"]);
private _wineYardInArea = (_distToWineYard < _radius);
if(_wineYardInArea)exitWith{true};
if(_radius > 500)exitWith{true};

false;