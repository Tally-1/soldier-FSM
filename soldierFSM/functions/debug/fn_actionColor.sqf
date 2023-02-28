params["_action"];
private _default	= [0.5,0.6,0.4,1];


if("none" 			          isEqualTo _action)	exitWith{_default};
if("reacting" 			      isEqualTo _action)	exitWith{[0.3,0.3,0.8,1]};
if("! Suppressed !" 	      isEqualTo _action)	exitWith{[0.9,0.1,0.1,1]};
if("Fleeing" 			      isEqualTo _action)	exitWith{[0.9,0.1,0.1,1]};
if("flinch" 			      isEqualTo _action)	exitWith{[0.6,0.2,0.2,1]};
if("dodging" 			      isEqualTo _action)	exitWith{[0.85,0.4,0,1]};
if("rearming" 			      isEqualTo _action)	exitWith{[0.85,0.4,0,1]};
if("Moving to fire-position"  isEqualTo _action)	exitWith{[0.85,0.4,0,1]};
if("return fire" 		      isEqualTo _action)	exitWith{[0.8,0.3,0.4,1]};
if("return direct fire"       isEqualTo _action)    exitWith{[0.4,0.3,0.8,1]};
if("emergency heal" 	      isEqualTo _action)	exitWith{[0.9,0.1,0.1,1]};
if("dodging to cover"         isEqualTo _action)	exitWith{[0.5,0.25,0,1]};
if("No cover panic!"          isEqualTo _action)	exitWith{[0.9,0.1,0.1,1]};
if("Sprinting!!"	          isEqualTo _action)	exitWith{[0.2,0.6,0,1]};

if("Get out! house is about to explode"isEqualTo _action)exitWith{[0.9,0.1,0.1,1]};

if("Picking up"         in _action)	exitWith{[0.85,0.4,0,1]};
if("leaving" 	        in _action)	exitWith{[0.3,0.3,1,1]};
if("success" 	        in _action)	exitWith{[0.3,0.8,0,1]};
if("taking cover" 	    in _action)	exitWith{[0.5,0.25,0,1]};
if("failed"			    in _action)	exitWith{[0.9,0.1,0.1,1]};
if("explosive"		    in _action)	exitWith{[0.85,0.4,0,1]};
if("CQB" 			    in _action)	exitWith{[0.1,0.5,0,1]};
if("Hiding"             in _action) exitWith{[0.5,0.25,0,1]};
if("Suppressing"        in _action) exitWith{[0,0,1,1]};
if("!Targeting Enemy!"  in _action)	exitWith{[0.9,0.1,0.1,1]};
if("Targeting"          in _action) exitWith{[0,0,1,1]};
if("Moving to position" in _action)	exitWith{[0.5,0.25,0,1]};



_default