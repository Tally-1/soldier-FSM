// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _minValue = 1;
private _doubleCheck = false;
params["_man", "_target", "_minValue", "_doubleCheck"];
private _visibility = [_man, "VIEW", _target] checkVisibility [(aimPos _man), (aimPos _target)];
private _visible = _visibility >= _minValue;

if (_visible)exitWith{_visible;};
if!(_doubleCheck)exitWith{_visible;};

private _visibility2 = [_man, "VIEW", _target] checkVisibility [(eyePos _man), (eyePos _target)];

private _final = selectMax [_visibility, _visibility2];

_visible = _final >= _minValue;

_visible;