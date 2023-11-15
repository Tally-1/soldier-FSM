params["_victim", "_victimAnim"];
private _animExecType = "playMoveNow";

if("backhand" in _victimAnim
or("forehand" in _victimAnim))then{
	_animExecType = "switchMove";
};

[_victim, _victimAnim]remoteExecCall[_animExecType, _victim];

if(_victimAnim isEqualTo "acts_executionvictim_kill")
then{[_victim, "Acts_executionvictim_Loop"]remoteExecCall["playMove", _victim]};

true;