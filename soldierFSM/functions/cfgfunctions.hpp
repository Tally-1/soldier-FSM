class CfgFunctions
{
	class SFSM
	{
		class CQB
		{
           file = "\soldierFsm\functions\CQB";
		   class assignAllBuildings    {};
		   class assignBuilding        {};
		   class currentBuilding       {};
		   class unitIndoorPos         {};
		   class floorPositions        {};
		   class buildingFloors        {};
		   class unitsInBuilding       {};
		   class CQBlimitReached       {};
		   class initCQB               {};
		   class buildingPath          {};
		   class buildingExits         {};
		   class CQBTargetEnemies      {};
		   class clearCQBPos           {};
		   class clearBuilding         {};
		   class CQBposAvailable       {};
		   class CQBcoverPosFilter     {};
		   class moveIntoHouseInit     {};
		   class moveIntoHouseExec     {};
		   class endMoveIntoHouse      {};
		   class houseAvailable        {};
		   class nearestAvailableHouse {};
		   class endCQBclearing        {};
		};
		
		class misc
		{
			
			file = "\soldierFsm\functions\misc";
			class StoreSuppression		{};
			class onSuppression			{};
			class Roll					{};
			class unitData				{};
			class sinCosPos				{};
			
			class initReaction			{};
			class groupData				{};
			class manAvailable          {};
			class forceMoveToPos		{};
			class manLoaded             {};
			class unitInDoor            {};
			class isRealMan             {};
			class targetVisible         {};
			class allCurrentDestinations{};
			class manOverrunBy          {};
			class firePosLite           {};
			class killNearEnemies       {};
			
		};

        class vehicles
		{
            file = "\soldierFsm\functions\vehicles";
			class vehicleData           {};
			class vehicleHeard          {};
			class availableVehicles     {};
			class vehicleAvailable      {};
			class UnitsNearVehicles     {};
			class endGetInVehicle       {};
			class otherSideInVehicle    {};
			class initGetInVehicle      {};
			class hijackAllVehicles     {};
			class hijackVehicle         {};
			class getInVehicle          {};
			class vehicleNeedsCrew      {};
			class reinforceVehicles     {};

		};


		class taskManagement
		{
			file = "\soldierFsm\functions\taskManagement";
			class HandleSuppression 	{};
			class TaskManager           {};
			class tenSecondTasks		{};
			class unitTasks				{};
			class vehicleTasks          {};
			class updateVehicle         {};
			class groupTasks			{};
			class handleGroupStance     {};
			class deleteDeadData        {};
			
		};

		class projectileHandling
		{
			file = "\soldierFsm\functions\projectileHandling";
			class soundReaction         {};
			class reactToExplosion      {};
			class addCrater             {};
			class handleBulletImpact    {};
			class handleExplosion       {};
			class handleGrenade         {};
			class throwBackGrenade      {};
			class evadeGrenade          {};
		};

		class curator
		{
			file = "\soldierFsm\functions\curator";
			class zWPplaced             {};
			class zWPdeleted            {};
		};
		
		class eventHandlers
		{
			file = "\soldierFsm\functions\eventHandlers";
			class SuppressedEH			{};
			class hitEH					{};
			class firedEH				{};
			class endHealEH				{};
			class curatorEH             {};
			class spottedCustomEH		{};
			class enemySpotted          {};
			class unitKilled            {};
			class unitCreated           {};
			class projectileEH			{};
			class explosionEH			{};
			class bulletEH			    {};
			class vehicleFiredEh        {};
			class enemyDetected			{};
			class gameLoaded            {preInit = 1};
			class gameLoadedWarning     {};
			class putAnimDoneEH         {};
		};

		class explosives 
		{
			file = "\soldierFsm\functions\explosives" 
			class canBlowUpHouse        {};
			class carriedExplosives     {};
			class formatExplosiveName   {};
			class getChargeFromBackPack {};
			class initHouseDemolition   {};
			class placeExplosive        {};
			class blowUpHouse           {};
		}

		class launchers
		{
			file = "\soldierFsm\functions\launchers" 
			class rpgHouse          {};
			class launcherHandler   {};
			class forceFireLauncher {};
			class canRpgHouse       {};
			class steerMissile      {};
			class guideMissile      {};
		}

		class dodging
		{
			file = "\soldierFsm\functions\dodging";
			class dodgeEnded			{};
			class EndDodge				{};
			class Dodge					{};
			class GetDodgePos			{};
			class canDodge				{};
			class getLateralPos			{};
			class groupCanDodge         {};
			class forceCoverDodge       {};
			
			
		};
		
		class flinching 
		{
			file = "\soldierFsm\functions\flinching";
			class canFlinch				{};
			class endFlinch				{};
			class flinch 				{};
			class bigBulletFlinch		{};
			class standardFlinch		{};
			class execStandardFlinch	{};
			class normalizeStance		{};
			class bigFlinchCover        {};
			
		};

		class reactiveFire
		{
			file = "\soldierFsm\functions\reactiveFire";
			class canReactFire			{};
			class reactFire				{};
			class endReactiveFire		{};
			class directReactFire		{};
			class unitTounitForcedFire	{};
			class unitAimedAtTarget		{};
			class unitWeaponDir			{};
			class multiplyReactionFire	{};
		};

		class rearming
		{
			file = "\soldierFsm\functions\rearming";
			class rearm            {};
			class canRearm         {};
			class needMachinegun   {};
			class canRearmWeapon   {};
			class getNewWeapon     {};
			class validRearm       {};
			class rearmAtSupply    {};
			class endRearm         {};
			class hasMagsForWeapon {};
			class getBestSupply    {};
			class primaryWeaponMags{};
		};

        class startEngagement
        {
            file = "\soldierFsm\functions\startEngagement";
            class AtSpecialistInitFight  {};
            class targetInfWithLauncher  {};
            class reactTovehicles        {};
            class unkillableEnemyVehicle {};
            class eyelidTrench           {};
            class getEnemyVehicles       {};
            class specialInitFightActions{};
            class machineGunInitFight    {};
            class supressPositions       {};
			class moveToFirePos          {};
			class findFirePos            {};
        };

        class startEngagement_takeCover
        {
            file = "\soldierFsm\functions\startEngagement\takeCover";
            class getCoverPos            {};
            class fightInitCover         {};
            class takeCover              {};
            class endTakeCover           {};
            class selectCoverPos         {};
            class postCoverActions       {};
            class initTakeCover          {};
            class stayInCover            {};
            class endStayInCover         {};
            class eventTriggeredCover    {};
        };

        class startEngagement_hide
		{
            file = "\soldierFsm\functions\startEngagement\hide";
            class findHidePos            {};
            class hideFromVehicle        {};
            class initHideFromVeh        {};
            class moveToHidePos          {};
            class doHide                 {};
            class doHideCQB              {};
            class execHiding             {};
        };

		class init
		{
			file = "\soldierFsm\functions\init";
			class serverInit			{};
			class initSettings			{};
			class postConfig			{};
			class initClient			{};
			class initSFSM				{postInit = 1};
			class InitMan				{};
			class initGroup             {};
			class initVehicle           {};
		};

		class debug
		{
			file = "\soldierFsm\functions\debug";
			class 3dDebug				{};
			class 3DdebugText			{};
			class actionColor			{};
			class drawObjectMarker      {};
			class multiple3dmarkers     {};
			class battlefield3d			{};
			class man3dInfo             {};
			class debugMessage			{};
			class hunkerObj3d			{};
			class manInfo               {};
			class logSettings           {};
			class deleteWarning         {};
		};
		
		class healing
		{
			file = "\soldierFsm\functions\healing";
			class proneHeal				{};
			class endSelfHeal			{};
			class canSelfHeal			{};
		};
		class battlefield
		{
			file = "\soldierFsm\functions\battlefield";
			class InitBattlefield		  {};
			class battlefieldPostInit	  {};
			class battlefieldEnd		  {};
			class getZones				  {};
			class getZone				  {};
			class getCoverPositionsLight  {};
			class clusterCoverPosLight    {};
			class battlefieldRadius       {};
			class nearestBattle			  {};
			class battleInitType          {};
			class battlefieldVariables    {};
			class updateBattlefield       {};
			class sidesFromString         {};
			class battlingUnits           {};
			class battleEnded             {};
			class battleFieldUpdater      {};
			class triggerBattleOnShot	  {};
			class canTriggerBattleShot	  {};
			class canSpotInitBattle       {};
			class excludeCpos  			  {};
			class getBattlefield		  {};
			class getEnemyPositions		  {};
			class updateHunkerObjects	  {};
			class initGrid                {};
			class updateGrid              {};
			class AddWeaponsToBattlefield {};
			class emergencyRearm          {};
			class getBattlefieldWeapon    {};
			class pickUpWeapon            {};
			class canPickUpWeapon         {};
			class endWeaponPickup         {};
			class useLightScan            {};
			class battleFieldCQB          {};
			class battleFieldSupplies     {};
			class battleFieldMachineGuns  {};
		};
		
		class markers
		{
			file = "\soldierFsm\functions\markers";
			class posMarker				{};
			class drawCircle			{};
			class bfDebugMarkers		{};
			class drawCoverPositions	{};
		};

		class objectData
		{
			file = "\soldierFsm\functions\objectData";
			class glRifle				{};
			class ObjStance				{};
			class areaData				{};
			class getMapObjects			{};
			class excludedMapObject		{};
			class filterMapObjects		{};
			class terrainObjData		{};
			class squadAsset			{};
			class hasAmmoForWeapon      {};
			class isMachineGunner       {};
		};
		class hunkerDown
		{
			file = "\soldierFsm\functions\hunkerDown";
			class getHunkerObject		{};
			class initHunker			{};
			class isHunkerObject        {};
			class hunkAvailable			{};
			class getAvHunkObject		{};
			class filterHunkerObjects	{};
			class hunkObjHash	        {};
			class hunkerFSM				{};
			class hunkerFsmStatus		{};
			class addHunkerObjData		{};
			class setHobjPositions		{};
			class moveToHunkerPos		{};
			class endHunker				{};
			class initHunkerFSM			{};
			class handleHunkerStatus	{};
			class randomHunkerInit		{};

		};
	};

	class Tcore
	{
		class core
		{
			file = "\soldierFsm\functions\core";
			class average				{};
			class decimals				{};
			class addZ					{};
			class roundPos				{};
			class avgPos				{};
			class get360Positions		{};
			class nearestPos			{};
			class getMidpoint           {};
			class sinCosPos				{};
			class findValidPos          {};
			
			class formatDir 			{};
			class avgRelDir				{};
			class inDirRange 			{};
			
			class object3DShape			{};
			class objPosData			{};
			class simpleObjectType		{};

			class clusterPos			{};
			class allClustersInRadius	{};
			class ClusterTerrainObjects	{};
			class positionsClusterArr	{};
			class clusterSize			{};
			class clusterMarker			{};
			class ClusterSides			{};
			
			class ClusterUnits			{};
			class ClusterVehicles		{};
			class clusterGroups         {};

			class unitCoverPosArr		{};
			class posCoverPosArr		{};
			class coverPosStance		{};
			class objCoverPosLight		{};
			class coverPosSimple		{};
			class visibleFromPositions	{};
			
			class debugMessage			{};
			class closestLocationName	{};
			class getLocationNamePos	{};
			
			class describeDir			{};
			class describeDistance		{};
			class stringToVarName		{};
			class areaName				{};			
			
			class toArrFromArr			{};
			
			class nearKnownEnemies      {};
			class knownDirToEnemy       {};
			class getLosTarget			{};
			class deadCrew				{};
			class grid100Pos            {};
			class substringsPresent     {};
			class playerLedGrp          {};
			class isPlayer				{};

			class toggleAiMoveInhibitors{};
			class deadMenInArea         {};
			class nearSoldiers          {};

			class nilNull				{};
			class posArrToPathPosArr    {};
			class avgHeight             {};
			class unitArrAimPositions   {};
			class posFromObjArr         {};

			class getPos                {};
			class straightPosArr        {};
			class squareGrid            {};
			class visibility            {};
			class sortByDist            {};
		};
	};

    #include "PR\cfgFunctions.hpp"
};