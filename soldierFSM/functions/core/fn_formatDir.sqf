private _round = true;
params["_dir", "_round"];
if!(_round)exitWith{((_dir + 360) % 360);};
_dir = round((_dir + 360) % 360);

_dir;