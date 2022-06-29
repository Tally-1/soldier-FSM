params["_dir"];
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

" of "