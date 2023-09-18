params[
    "_coefCenter", 
    "_coefFlank",
    "_debug"
];

if(_coefFlank > 0.5)then{
    private _potentialOverLap = _coefFlank  - 0.5;
    private _neededCenter     = _coefCenter - 0.5;
    private _overLap          = (_coefCenter+_potentialOverLap)-1;
    
    if(_overLap > 0)then{
        _coefFlank = _coefFlank - _overLap;
    };

    if(_overLap > 0
    &&{_debug})then{
        // private _degOverlap = round (180*_overLap);
        systemChat "Flank-sector overlaps Fire-sector";
    };
};

_coefFlank;