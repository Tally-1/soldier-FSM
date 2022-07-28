params["_man", "_enable"];

if(_enable)
exitwith{
			_man enableAI "TARGET";
			_man enableAI "AUTOCOMBAT";
			_man enableAI "AUTOTARGET";
			_man enableAI "TARGET";
		};

_man disableAI "TARGET";
_man disableAI "AUTOCOMBAT";
_man disableAI "AUTOTARGET";
_man disableAI "TARGET";

true;