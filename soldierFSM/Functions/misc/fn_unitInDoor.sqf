// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

//original author: KillZone Kid, the function is found at: https://community.bistudio.com/wiki/lineIntersectsWith
// i did edit it slightly to deal ith undefined values.
// Be aware that all lineIntersects commands are heavy and
// should be used with caution.
lineIntersectsSurfaces [
        getPosWorld _this,
        getPosWorld _this vectorAdd [0, 0, 10],
        _this, objNull, true, 1, "GEOM", "NONE"
    ] select 0 params ["","","","_house"];

if (isNil "_house")exitWith{false};

if (_house isKindOf "House") exitWith {true};

false;