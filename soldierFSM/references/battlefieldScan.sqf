/*
OUTPUT:
HASHMAP: ALL BATTLES -> EACH BATTLE USES (round)POS AS KEY
BATTLEHASH ARRAY OF HASHMAP
EXAMPLE:
****= arrray of hashValues representing objects
*** = array of clusterArrays  [[_pos, _clusterRadius, _Side]] (side = side holding this zone)
**  = array of coverPosArrays [[_pos, _objectType, _stanceClass, _Side]] (side = the side that takes cover here)
*   = array of hashMaps ["hashValue", [
										["pos", [0,0,0]] 
										["type", "rock"],
										["ownerUnit", *hashValue*],
										["data", [*obj3Ddata*]]
									  ]
						]
["[0,0,0]",
	["name", "1km north-west of Athira"],
	["radius", 300],
	["Started" 32],
	["lastDataUpdate", 10],
	["clusterPositions", [***]],
	["coverPositions", [**]],
	["mapObjects", [*]],
	["sides", [east, west, guer]],
	["units", [****]],
	["vehicles", [****]]
]

*/