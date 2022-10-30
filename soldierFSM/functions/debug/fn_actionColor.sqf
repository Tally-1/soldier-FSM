params["_action"];
private _default	= [0.5,0.6,0.4,1];


if("none" 			          == _action)	exitWith{_default};
if("reacting" 			      == _action)	exitWith{[0.3,0.3,0.8,1]};
if("! Suppressed !" 	      == _action)	exitWith{[0.9,0.1,0.1,1]};
if("Fleeing" 			      == _action)	exitWith{[0.9,0.1,0.1,1]};
if("flinch" 			      == _action)	exitWith{[0.6,0.2,0.2,1]};
if("dodging" 			      == _action)	exitWith{[0.85,0.4,0,1]};
if("return fire" 		      == _action)	exitWith{[0.8,0.3,0.4,1]};
if("return direct fire"       == _action)   exitWith{[0.4,0.3,0.8,1]};
if("emergency heal" 	      == _action)	exitWith{[0.9,0.1,0.1,1]};
if("dodging to cover"         == _action)	exitWith{[0.5,0.25,0,1]};
if("No cover panic!"          == _action)	exitWith{[0.9,0.1,0.1,1]};
if("Picking up weapon"        == _action)	exitWith{[0.85,0.4,0,1]};
if("CQB: !Targeting Enemy!"   == _action)	exitWith{[0.9,0.1,0.1,1]};

if("Get out! house is about to explode"==_action)exitWith{[0.9,0.1,0.1,1]};

if("leaving" 	        in _action)	exitWith{[0.3,0.3,1,1]};
if("success" 	        in _action)	exitWith{[0.3,0.8,0,1]};
if("taking cover" 	    in _action)	exitWith{[0.5,0.25,0,1]};
if("failed"			    in _action)	exitWith{[0.9,0.1,0.1,1]};
if("explosive"		    in _action)	exitWith{[0.85,0.4,0,1]};
if("CQB" 			    in _action)	exitWith{[0.1,0.5,0,1]};
if("Hiding"             in _action) exitWith{[0.5,0.25,0,1]};
if("Suppressing"        in _action) exitWith{[0,0,1,1]};
if("Targeting"          in _action) exitWith{[0,0,1,1]};
if("Moving to position" in _action)	exitWith{[0.5,0.25,0,1]};


_default