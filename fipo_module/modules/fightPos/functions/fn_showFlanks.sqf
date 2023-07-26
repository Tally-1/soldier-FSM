params["_fipo"];
if(typeOf _fipo isNotEqualTo "SFSM_FIPO")                         exitWith{false;};
if((_fipo getVariable ["showIndicators", false]) isEqualTo false) exitWith{false;};
if((_fipo getVariable ["rightFlank", false]) isEqualTo false
&&{(_fipo getVariable ["leftFlank",  false]) isEqualTo false})    exitWith{false;};

true;