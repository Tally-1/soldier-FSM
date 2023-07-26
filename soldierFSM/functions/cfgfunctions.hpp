class CfgFunctions
{
    class SFSM
    {
        class audioFeedback
        {
            file = "\soldierFSM\functions\audioFeedback";
            class SquadSay        {};
            class say             {};
            class canSpeak        {};
            class speechEventsMan {};
            class getPhrase       {};
        }
        
        class CQB
        {
           file = "\soldierFSM\functions\CQB";
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
            
            file = "\soldierFSM\functions\misc";
            class StoreSuppression      {};
            class onSuppression         {};
            class unitData              {};
            class sinCosPos             {};
            class sinCosPos2            {};
            
            class initReaction          {};
            class groupData             {};
            class manAvailable          {};
            class manLoaded             {};
            class unitInDoor            {};
            
            class targetVisible         {};
            class allCurrentDestinations{};
            class manOverrunBy          {};
            class firePosLite           {};
            class killNearEnemies       {};
            
            class loadedAddons          {};
            class unitsInRangeSameSide  {};
            class getNearestOrPlayer    {};
            class relAimPos             {};
            class isPosition            {};
            class availableRegulars     {};
            class isUncon               {};
            class enableAutoStance      {};
            class disableAutoStance     {};
            class autoStanceActions     {};
            class showAutoStAction      {};
            class playableUnit          {};
            class playableGroup         {};

            class getNearest            {};
            class noBushNoMan           {};

            class getAction             {};
            class setAction             {};
            class inVehicle             {};

            class targetsAndVisibility  {};
            class stand                 {};
            class crouch                {};
            class hostile               {};
            class nearEnemies           {};

            class hasActiveWp           {};
            class animSetStance         {};

            class isPlayerGroup         {};
            class spamDoFire            {};
            class getFurthest           {};
            
            class canResetBrain         {};
            class deActivateMan         {};
            class activateMan           {};
            class abilitiesInUse        {};
            class getSquadIndex         {};
            class forceGroupJoin        {};
            class resetBrain            {};
            class inDirRange            {};
            class formatDirRanges       {};
            class selectionPos          {};
            class addToPosValues        {};
            class setDirAndPitchToPos   {};
            class canGoProne            {};
            class animThenExec          {};
            class onExecAnim            {};
            class execFromArr           {};

        };

        class movement
        {
            file = "\soldierFSM\functions\movement";
            class canSprint             {};
            class clearSprintPath       {};
            class sprint                {};
            class sprintInit            {};
            class sprintLooper          {};
            class sprintVarRemoval      {};

            class forceMoveToPos        {};
            class forceMove2            {};
            class postForceMove2        {};

            class objectsInPath         {};
            class calculatePath         {};
            class abortForcedMove       {};
            class moveToMan             {};

            class canRun                {};
            class forceMoveATL          {};

            class regroup               {};
            

        }

        class vehicles
        {
            file = "\soldierFSM\functions\vehicles";
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
            class vehicleActions        {};
            class enableHijack          {};
            class disableHijack         {};

        };


        class taskManagement
        {
            file = "\soldierFSM\functions\taskManagement";
            class HandleSuppression     {};
            class TaskManager           {};
            class tenSecondTasks        {};
            class fiveMinTasks          {};
            class unitTasks             {};
            class vehicleTasks          {};
            class updateVehicle         {};
            class groupTasks            {};
            class handleGroupStance     {};
            class deleteDeadData        {};
            class validCleanupObject    {};
            class garbageCollector      {};
            class minuteTasks           {};
            
        };

        class projectileHandling
        {
            file = "\soldierFSM\functions\projectileHandling";
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
            file = "\soldierFSM\functions\curator";
            class zWPplaced             {};
            class zWPdeleted            {};
        };
        
        class eventHandlers
        {
            file = "\soldierFSM\functions\eventHandlers";
            class SuppressedEH          {};
            class hitEH                 {};
            class firedEH               {};
            class endHealEH             {};
            class curatorEH             {};
            class spottedCustomEH       {};
            class enemySpotted          {};
            class unitKilled            {};
            class unitCreated           {};

            class projectileCreated     {};
            class projectileEH          {};
            class explosionEH           {};
            class bulletEH              {};

            class vehicleFiredEh        {};
            class enemyDetected         {};
            class gameLoaded            {preInit = 1};
            class gameLoadedWarning     {};
            class putAnimDoneEH         {};
            class PathCalculated        {};

            class leaderChangeEH        {};
            class antiRubberBand        {};
            
        };

        class explosives 
        {
            file = "\soldierFSM\functions\explosives" 
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
            file = "\soldierFSM\functions\launchers" 
            class rpgHouse          {};
            class launcherHandler   {};
            class forceFireLauncher {};
            class canRpgHouse       {};
            class steerMissile      {};
            class guideMissile      {};
            class forcedCqbRpg      {};
        }

        class dodging
        {
            file = "\soldierFSM\functions\dodging";
            class dodgeEnded            {};
            class EndDodge              {};
            class Dodge                 {};
            class GetDodgePos           {};
            class canDodge              {};
            class getLateralPos         {};
            class groupCanDodge         {};
            class forceCoverDodge       {};
            
            
        };
        
        class flinching 
        {
            file = "\soldierFSM\functions\flinching";
            class canFlinch             {};
            class endFlinch             {};
            class flinch                {};
            class canRoll               {};
            class Roll                  {};
            class proneFlinch           {};
            class bigBulletFlinch       {};
            class standardFlinch        {};
            class execStandardFlinch    {};
            class normalizeStance       {};
            class bigFlinchCover        {};

            class registerFlinch        {};
            class isPinnedDown          {};
            
        };

        class fightPos 
        {
            file = "\soldierFSM\functions\fightPos";
            class clearFipo         {};
            
            class getFipo           {};
            class inFipo            {};
            class nearestFipo       {};
            class handleFipoHit     {};
            class fipoAvailable     {};
            class nearGroupFiposs   {};
            class selectFipo        {};
            class assignFiposs      {};
            class fipoMenRegroup    {};
            class groupFipoAssigner {};
            class fipoFSM           {};
            class fipoManager       {};
            class canTeleportFipo   {};
            class checkFipoError    {};
            class getFipoMen        {};
            class animationMaps     {};
            class tempPegToFipo     {};
            
        };

        class actions
        {
            file = "\soldierFSM\functions\fightPos\actions";
            class fipoActions         {};
            class leaderGetOutFipo    {};
            class curatorGetOutFipo   {};
            class fipoRemoveUseless   {};
            class fipoCorrectPosition {};
            
            class initIdleFipoMove    {};
            class idleAnimEh          {};
            class idleFipoMan         {};
            class canDoIdleFipo       {};
            class abortIdleFipo       {};

            class getOutFipo          {};
            class getInFiPo           {};
            class moveInFipo          {};
            class moveOutFiPo         {};
            class failFipoMove        {};
            class canMoveInFipo       {};
            
        };

        class module
        {
            file = "\soldierFSM\functions\fightPos\module";
            class initFipo          {};
            class fipoMan           {};
            class moveInFipoSynced  {};
            class fipoMarker        {};
			class fipoAllowedMan    {};
			class fipoDefineSides   {};
			class fipoMarkerColor   {};
			class updateFipoMarker  {};
        };

        class peeking
        {
            file = "\soldierFSM\functions\fightPos\peeking";
            class peekEnded            {};
            class initFipoPeek         {};
            class fipoPeek             {};
            class peekActions          {};
            class canFipoPeek          {};
            class fipoPeekTime         {};
            class peekCoolDownTime     {};
            class fipoStanceIndexes    {};
            class getPeekTarget        {};
            class fipoManFired         {};
            class getFipoATtarget      {};
            class selectShootingStance {};
            class setFipoAnimOfset     {};
        };

        class sectors 
        {
            file = "\soldierFSM\functions\fightPos\sectors";
            class validSector         {};
            class inSector            {};
            class sectorEdgePositions {};
            class sector3D            {};
            class sector3DLines       {};
            class fipoFlankSectors    {};
            class showActiveFlanks    {};
            class fipoFlankEnemies    {};
            class fipoOutFlanked      {};
            class curatorFipoFlanks   {};
            class getObjectSector     {};
        };

        class hitAndRun
        {
            file = "\soldierFSM\functions\fightPos\hitAndRun";
            class fipoCooldownLeft    {};
            class fipoFiredEH         {};
            class fipoTimeUntilExit   {};
            class getOutFipoHitAndRun {};
            class fipoRun             {};
        };

        class overrun 
        {
            file = "\soldierFSM\functions\overrun";
            class initOverRun       {};
            class overRunAllies     {};
            class overRunDecision   {};
            class overRunFight      {};
            class overRun           {};
            class flee              {};
            class groupFlee         {};
            class groupFleeingEh    {};
            class canBeOverRun      {};
            class panic             {};
            class panicAction       {};
            class calmPanicked      {};
        }

        class capture
        {
            file = "\soldierFSM\functions\overrun\capture";
            class dropWeapon         {};
            class dropAllWeapons     {};
            class surrender          {};
            class capture            {};
            class execute            {};
            class executeAction      {};
            class captureAction      {};
            class joinSurrenderGroup {};
            class battleLost         {};
            
            class failRescue         {};
            class failAiCapture      {};
            class aiCaptureMan       {};
            class unconSurrPan       {};
            class canBeCaptured      {};
            class canCapture         {};
            class initCapture        {};
            class canRescue          {};
            class AiRescue           {};
            class initAiRescue       {};
            class helpOrCapture      {};
            class allAiRescueCapture {};
        };

        class reactiveFire
        {
            file = "\soldierFSM\functions\reactiveFire";
            class canReactFire          {};
            class reactFire             {};
            class endReactiveFire       {};
            class directReactFire       {};
            class unitTounitForcedFire  {};
            class unitAimedAtTarget     {};
            class unitWeaponDir         {};
            class multiplyReactionFire  {};
            class multiplyRF            {};
        };

        class rearming
        {
            file = "\soldierFSM\functions\rearming";
            class rearm            {};
            class canRearm         {};
            class needMachinegun   {};
            class needLauncher     {};
            class canRearmWeapon   {};
            class getNewWeapon     {};
            class validRearm       {};
            class rearmAtSupply    {};
            class endRearm         {};
            class hasMagsForWeapon {};
            class getBestSupply    {};
            class primaryWeaponMags{};
            class pickUpFreshAT     {};
            class availMagsForWeapon {};
        };

        class buddyRearm
        {
            file = "\soldierFSM\functions\rearming\buddyRearm";
            class buddyRearmAction   {};
            class isRearmBuddy       {};
            class canCallBuddyRearm  {};
            class getRearmingBuddy   {};
            class buddyRearmHint     {};
            class giveMagazines      {};
            class buddyRearm         {};

        }

        class marksmanFSM
        {
            file = "\soldierFSM\functions\marksmanFSM";
            class handleMarksmanHit       {};
            class marksmenInGroup         {};
            class getMarksMen             {};
            class isHVT                   {};
            class getHVTs                 {};
            class canHunt                 {};
            class activateMarksMen        {};
            class battlefieldMarksmen     {};
            class isFirePos               {};
            class selectTarget            {};
            class selectMarksmanTarget    {};
            class snipingPosGrid          {};
            class selectSnipingPos        {};
            class snipingPos              {};
            class viableTarget            {};
            class huntEnded               {};
            class correctTarget           {};
            class marksmanTargetControlEh {};
            class initHunt                {};
            class abortMoveToSnipePos     {};
            class MoveToSnipePos          {};
            class huntActions             {};
            class huntTarget              {};
            class marksmanReturnMove      {};
            class marksmanReturn          {};
            class endHunt                 {};
            class mrkMnKeepShooting       {};
            class marksmanFireAtTarget    {};
            class preyHandler             {};
        };

        class startEngagement
        {
            file = "\soldierFSM\functions\startEngagement";
            class canDoSpecial           {};
            class allowSpecial           {};
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

            class forcedRegroupNeeded     {};
            class forcedRegroup          {};
            class abortSpecial           {};

        };

        class startEngagement_takeCover
        {
            file = "\soldierFSM\functions\startEngagement\takeCover";
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
            file = "\soldierFSM\functions\startEngagement\hide";
            class findHidePos            {};
            class hideFromVehicle        {};
            class initHideFromVeh        {};
            class moveToHidePos          {};
            class doHide                 {};
            class doHideCQB              {};
        };

        class init
        {
            file = "\soldierFSM\functions\init";
            class serverInit            {};
            class initSettings            {};
            class postConfig            {};
            class initClient            {};
            class initSFSM                {postInit = 1};
            class InitMan                {};
            class initGroup             {};
            class initVehicle           {};

            class initCustomEvents      {};
            class initFiPositions       {};
        };

        class debug
        {
            file = "\soldierFSM\functions\debug";
            class 3dDebug               {};
            class aimLine               {};
            class actionColor           {};
            class drawObjectMarker      {};
            class drawAllAimLines       {};
            class multiple3dmarkers     {};
            class battlefield3d         {};
            class debugMessage          {};
            class hunkerObj3d           {};
            class logSettings           {};
            class deleteWarning         {};
            class custom3Dmarkers       {};
            class flashAction           {};
            class onDbgCurKey           {};
            class debugCuratorKeyHandler{};
            class debugCuratorInterface {};
            class drawBullets           {};
            class bulletTracker         {};
            class trajectory            {};
            class drawTrajectory        {};
            class drawAllTrajectories   {};
            class drawFiPositions       {};
            class sideColor             {};

            class isDebugActive         {};
            class debugController       {};
            class draw3Dsectors         {};
            class drawSector3D          {};
            class add3Dsector           {};

        };

        class debugMan
        {
            file = "\soldierFSM\functions\debug\debugMan";
            class manInfo               {};
            class man3dInfo             {};
            class 3DdebugText           {};
            class dbgTxtRPS             {};
            class dbgTxtSupression      {};
            class dbgTxtAction          {};
            class dbgTxtExcluded        {};
            class dbgTxtUncon           {};
            class dbgTxtInjured         {};
            class dbgTxtSprint          {};
            class dbgTxtFipo            {};
            class dbgTxtMarksman        {};
            class dbgTxtSnipeTarget     {};
            class dbgTxtSniper          {};
            class dbgTxtFirePos         {};
            class dbgTxtSelectedMan     {};
            class dbgTxtActionText      {};
            class dbgTxtForcedMovement  {};
        };
        
        class healing
        {
            file = "\soldierFSM\functions\healing";
            class proneHeal             {};
            class endSelfHeal           {};
            class canSelfHeal           {};
            class hasMedkit             {};
            class nearestHealer         {};
            class initBuddyHeal         {};
            class canBuddyHeal          {};
            class buddyHeal             {};
            class endBuddyHeal          {};
            class reviveAnim            {};
            class buddyRevive           {};
            class endBuddyRevive        {};
            class initDragMan           {};
            class dragStatus            {};
            class drag                  {};
            class dragMan               {};
            class endDragMan            {};
            class dragPos               {};
            class searchAndRevive       {};

            class getGroupHealer        {};
            class playerNeedsMedic      {};
            class canCallMedic          {};
            class playerHealHint        {};
            class callPlayerMedic       {};
            class playerCallMedicAction {};
            class nearestValidReviver   {};
            class sortRevivers          {};
            class sortUnconscious       {};
        };


        class battlefield
        {
            file = "\soldierFSM\functions\battlefield";
            class InitBattlefield         {};
            class battlefieldPostInit     {};
            class battlefieldEnd          {};
            class getZones                {};
            class getZone                 {};
            class getCoverPositionsLight  {};
            class clusterCoverPosLight    {};
            class battlefieldRadius       {};
            class nearestBattle           {};
            class battleInitType          {};
            class battlefieldVariables    {};
            class updateBattlefield       {};
            class sidesFromString         {};
            class battlingUnits           {};
            class battleEnded             {};
            class battleFieldUpdater      {};
            class triggerBattleOnShot     {};
            class canTriggerBattleShot    {};
            class canSpotInitBattle       {};
            class excludeCpos             {};
            class getBattlefield          {};
            class getEnemyPositions       {};
            class updateHunkerObjects     {};
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

            class battleFieldMedical      {};
            class battleFieldMedicLoop    {};
            class getWoundedAndHealers    {};
            class assignBattlefieldTurrets{};
            class leaveBattlefieldTurrets {};
            class bffKnowEachOther        {};

            class battleOverRun           {};
            class BffOverRunLoop          {};
            class bffEnemyVehicles        {};

            class battlefieldDimensions   {};
            class battlefieldRevives      {}; 

        };
        
        class markers
        {
            file = "\soldierFSM\functions\markers";
            class posMarker             {};
            class drawCircle            {};
            class bfDebugMarkers        {};
            class drawCoverPositions    {};
        };

        class objectData
        {
            file = "\soldierFSM\functions\objectData";
            class glRifle               {};
            class ObjStance             {};
            class areaData              {};
            class getMapObjects         {};
            class excludedMapObject     {};
            class filterMapObjects      {};
            class terrainObjData        {};
            class squadAsset            {};
            class hasAmmoForWeapon      {};
            class validEnemy            {};
            class validEnemyVehicle     {};
            class isMachineGunner       {};
            class isATSoldier           {};
            class isMarksman            {};
            class isRealMan             {};
            class isMedic               {};
            class isFipoMedic           {};
            class isPlayer              {};
            class isDeactivated         {};            
            
            class availableAiSoldier    {};
            class buildingCenterPosASL  {};
            class availEnemyFriendDist  {};
            
            
        };

        class hunkerDown
        {
            file = "\soldierFSM\functions\hunkerDown";
            class getHunkerObject     {};
            class initHunker          {};
            class isHunkerObject      {};
            class hunkAvailable       {};
            class getAvHunkObject     {};
            class filterHunkerObjects {};
            class hunkObjHash         {};
            class hunkerFSM           {};
            class hunkerFsmStatus     {};
            class addHunkerObjData    {};
            class setHobjPositions    {};
            class moveToHunkerPos     {};
            class endHunker           {};
            class initHunkerFSM       {};
            class handleHunkerStatus  {};
            class randomHunkerInit    {};

        };

        class turrets
        {
            file = "\soldierFSM\functions\turrets";
            class isTurret              {};
            class getTurretsAndLeaders  {};
            class assignTurret          {};
            class canGetInTurret        {};
            class turretAvailable       {};
            class turretRunEnded        {};
            class mountTurret           {};
            class getInTurret           {};
            class failTurretMount       {};
            class removeTurretVars      {};
            class onGetOutTurret        {};
            class canStayInTurret       {};
            class turretGetOut          {};
            class groupLeaveTurrets     {};
            class manAllTurrets         {};
        };
    };

    class Tcore
    {
        class core
        {
            file = "\soldierFSM\functions\core";
            class average              {};
            class decimals              {};
            class addZ                  {};
            class roundPos              {};
            class avgPos                {};
            class get360Positions       {};
            class nearestPos            {};
            class getMidpoint           {};
            class sinCosPos             {};
            class findValidPos          {};
            
            class formatDir             {};
            class avgRelDir             {};
            class inDirRange            {};
            
            class object3DShape         {};
            class objPosData            {};
            class simpleObjectType      {};

            class clusterPos            {};
            class allClustersInRadius   {};
            class ClusterTerrainObjects {};
            class positionsClusterArr   {};
            class clusterSize           {};
            class clusterMarker         {};
            class ClusterSides          {};
            
            class ClusterUnits          {};
            class ClusterVehicles       {};
            class clusterGroups         {};

            class unitCoverPosArr       {};
            class posCoverPosArr        {};
            class coverPosStance        {};
            class objCoverPosLight      {};
            class coverPosSimple        {};
            class visibleFromPositions  {};
            
            class debugMessage          {};
            class closestLocationName   {};
            class getLocationNamePos    {};
            
            class describeDir           {};
            class describeDistance      {};
            class stringToVarName       {};
            class areaName              {};            
            
            class toArrFromArr          {};
            
            class nearKnownEnemies      {};
            class knownDirToEnemy       {};
            class getLosTarget          {};
            class deadCrew              {};
            class grid100Pos            {};
            class substringsPresent     {};
            class playerLedGrp          {};
            class isPlayer              {};

            class toggleAiMoveInhibitors{};
            class deadMenInArea         {};
            class nearSoldiers          {};

            class nilNull               {};
            class posArrToPathPosArr    {};
            class avgHeight             {};
            class unitArrAimPositions   {};
            class posFromObjArr         {};

            class getPos                {};
            class straightPosArr        {};
            class squareGrid            {};
            class visibility            {};
            class sortByDist            {};
            class setTextTexture        {};

            class availablePositions    {};
            class positionClear         {};
        };
    };
    
    #include "PR\cfgFunctions.hpp"
};