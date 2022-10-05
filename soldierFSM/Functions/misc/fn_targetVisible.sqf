params["_man", "_target"];
private _visibility = [_man, "VIEW", _target] checkVisibility [(aimPos _man), (aimPos _target)];
private _visible = _visibility == 1;
_visible;