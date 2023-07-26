params["_pos", "_color", "_rps"];
private _txt = [_rps, " Incoming rounds"] joinString "";

drawIcon3D     [
                        "",                //texture (icon type)
                        _color,            //color
                        _pos,            //position
                        0.2,             //size X
                        0.2,             //size Y
                        0,                  //angle
                        _txt,             //text
                        2,                 //shadow
                        0.03            //textSize
                    ];

true;