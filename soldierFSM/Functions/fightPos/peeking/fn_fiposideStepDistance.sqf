params[
    ["_fipo",nil,[objNull]]
];
private _coverStance = _fipo getVariable "coverstance";
private _coverAnim   = SFSM_animStances  get _coverStance;
private _unitPos     = _coverAnim#1;
private _distance    = (FIPO_sideStepAnimData get _unitPos)#3;

_distance;