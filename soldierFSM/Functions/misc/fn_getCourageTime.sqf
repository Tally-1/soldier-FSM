params["_man", "_time"];
private _courage = _man skill "courage"; if(_courage <= 0)then{_courage = 0.0001;};
private _max     = _time *2;
private _min     = _time /2; 
private _coef    = 0.5/_courage;
private _newTime = _time*_coef;

if(_newTime < _min)then{_newTime = _min;};
if(_newTime > _max)then{_newTime = _max;};

_newTime;