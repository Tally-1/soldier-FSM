// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_hunkerObjData", "_objData"];
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

true;