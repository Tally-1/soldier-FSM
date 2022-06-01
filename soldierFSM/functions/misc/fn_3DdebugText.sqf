params["_man"];
if(isPlayer _man)exitwith{};
if!(typeOf (vehicle _man) == typeOf _man)exitwith{};//if man is in a vehicle

private _3dPos		= (ASLToAGL getPosASL _man);
private _supp		= [(getSuppression _man), 2]call ObjScan_fnc_Decimals;
private _rps		= [_man, "roundsPrSecond"] 	call SFSM_fnc_unitData;
private _action		= [_man, "action"] 			call SFSM_fnc_unitData;

private _actionTxt   = ["Action: ", _action] 		joinString "";
private _supTxt		 = ["Supression: ", _supp] 		joinString "";
private _incomingTxt = [_rps, " Incoming rounds"] 	joinString "";

private _suppColor 	= [_supp, 0.4, 0.4, 1];
private _actColor	= [0.5,0.6,0.4,1];

private _actionPos 	= [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 2.3)];
private _supPos 	= [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 2.1)];
private _incPos 	= [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 1.9)];

if(isNil "_action")			then{_actionTxt = "unknown"};
if(_action == "flinch")	then{_actColor = [0.9,0.2,0.2,1]};
if(_action == "dodging")then{_actColor = [0.85,0.4,0,1]};

/*
3D icons works in layers, the last one to be added is on the top.
Hence the action-text is placed last
*/

//incoming bullets
if(_rps > 1)
then{
		drawIcon3D 	[
						"",				//texture (icon type)
						_suppColor,		//color
						_incPos,		//position
						0.2, 			//size X
						0.2, 			//size Y
						0, 	 			//angle
						_incomingTxt, 	//text
						2, 				//shadow
						0.03			//textSize
					];
	};

//suppression level

if(_supp > 0)
then{
drawIcon3D 	[
				"",			
				_suppColor,	
				_supPos,	
				0.2, 		
				0.2, 		
				0, 	 		
				_supTxt, 	
				2, 			
				0.03		
			];
};
//current action
drawIcon3D 	[
				"",			
				_actColor,	
				_actionPos,	
				0.2, 		
				0.2, 		
				0, 	 		
				_actionTxt, 
				2, 			
				0.03		
			];


true;