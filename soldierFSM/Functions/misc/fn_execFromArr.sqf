params["_params", "_scheduled", "_code"];
private ["_returnVal"];

if(typeName _scheduled isEqualTo "CODE")then{
    _code      = _scheduled;
    _scheduled = false;
};

if(_scheduled)then{
     _returnVal = _params spawn _code;
}else{
    isNil{_returnVal = _params call _code;};
};

_returnVal;