params[
    ["_fipo",nil,[objNull]]
];
private _coverStance = _fipo getVariable "coverstance";
private _coverAnim   = SFSM_animStances  get _coverStance;
private _unitPos     = _coverAnim#1;
if(_unitPos isEqualTo "DOWN")   exitWith  {0.4};
if(_unitPos isEqualTo "MIDDLE") exitWith  {1};
if(_unitPos isEqualTo "UP")     exitWith  {1.52};

1.6;