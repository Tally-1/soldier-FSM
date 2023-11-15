params["_captorAnim"];
private _mirrorMapArr = [
	["acts_executioner_backhand",  "acts_executionvictim_backhand"],
	["acts_executioner_forehand",  "acts_executionvictim_forehand"],
	["acts_executioner_squat",     "acts_executionvictim_kill"],
	["acts_executioner_standing",  "acts_executionvictim_kill"],
	["acts_executioner_kill",      "acts_executionvictim_kill"]
];
private _mirrorMap = createHashMapFromArray _mirrorMapArr;

(_mirrorMap get _captorAnim);