params["_fipo"];
private _allZones   = [];
private _fireZones  = [];
private _flankZones = [];


{if(typeOf _x isEqualTo "SFSM_AZ")then{

    private _data = _x getVariable "SFSM_AzData";
    private _mode = _data get "mode";
    if(_mode isEqualTo "activate")
    then{_fireZones  pushBack _data;}
    else{_flankZones pushBack _data;};
    _allZones pushBack _data;

}} forEach (synchronizedObjects _fipo);


[_allZones, _fireZones, _flankZones];