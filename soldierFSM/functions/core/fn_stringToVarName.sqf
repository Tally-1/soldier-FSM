params["_string", "_startString", "_endString"];

private _operators  = "+-*/#()[];,.:%=" splitString "";
private _numbers    = "0123456789_" splitString "";
private _name       = [];
private _iterations = (count _string)-1;


for "_i" from 0 to _iterations
do{
    if(_i == 0
    && {!isNil "_startString"})
    then{_name pushBack _startString};
    
    private _letter   = _string select [_i, 1];
    private _number   = _letter in _numbers;
    private _operator = _letter in _operators;
    private _excluded = (count _name) == 0 && {_number};
    
    
    if(_excluded)then{_name pushBack "Var_"};
    if!(_operator)
    then{
          if(_letter == " ")then{_name pushBack "_"}
                              else{_name pushBack _letter};
        };
    
    if(_i == _iterations
    && {!isNil "_endString"})
    then{_name pushBack _endString};    
};

_name = _name joinString "";

_name