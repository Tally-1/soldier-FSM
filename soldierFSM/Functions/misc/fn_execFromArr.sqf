params["_params", "_scheduled", "_code"];
private ["_returnVal"];

if(_scheduled)then{
     _returnVal = _params spawn _code;
}else{
    isNil{_returnVal = _params call _code;};
};

_returnVal;