class CfgFunctions
{
	class SFSM
	{
		class CQB
		{
           class assignAllBuildings    {file = "\soldierFSM\functions\CQB\fn_assignAllBuildings.sqf"};
		   class assignBuilding        {file = "\soldierFSM\functions\CQB\fn_assignBuilding.sqf"};
		   class currentBuilding       {file = "\soldierFSM\functions\CQB\fn_currentBuilding.sqf"};
		   class unitIndoorPos         {file = "\soldierFSM\functions\CQB\fn_unitIndoorPos.sqf"};
		   class floorPositions        {file = "\soldierFSM\functions\CQB\fn_floorPositions.sqf"};
		   class buildingFloors        {file = "\soldierFSM\functions\CQB\fn_buildingFloors.sqf"};
		   class unitsInBuilding       {file = "\soldierFSM\functions\CQB\fn_unitsInBuilding.sqf"};
		   class CQBlimitReached       {file = "\soldierFSM\functions\CQB\fn_CQBlimitReached.sqf"};
		   class initCQB               {file = "\soldierFSM\functions\CQB\fn_initCQB.sqf"};
		   class buildingPath          {file = "\soldierFSM\functions\CQB\fn_buildingPath.sqf"};
		   class buildingExits         {file = "\soldierFSM\functions\CQB\fn_buildingExits.sqf"};
		   class CQBTargetEnemies      {file = "\soldierFSM\functions\CQB\fn_CQBTargetEnemies.sqf"};
		   class clearCQBPos           {file = "\soldierFSM\functions\CQB\fn_clearCQBPos.sqf"};
		   class clearBuilding         {file = "\soldierFSM\functions\CQB\fn_clearBuilding.sqf"};
		   class CQBposAvailable       {file = "\soldierFSM\functions\CQB\fn_CQBposAvailable.sqf"};
		   class CQBcoverPosFilter     {file = "\soldierFSM\functions\CQB\fn_CQBcoverPosFilter.sqf"};
		   class moveIntoHouseInit     {file = "\soldierFSM\functions\CQB\fn_moveIntoHouseInit.sqf"};
		   class moveIntoHouseExec     {file = "\soldierFSM\functions\CQB\fn_moveIntoHouseExec.sqf"};
		   class endMoveIntoHouse      {file = "\soldierFSM\functions\CQB\fn_endMoveIntoHouse.sqf"};
		   class houseAvailable        {file = "\soldierFSM\functions\CQB\fn_houseAvailable.sqf"};
		   class nearestAvailableHouse {file = "\soldierFSM\functions\CQB\fn_nearestAvailableHouse.sqf"};
		};
		
		class misc
		{
			
			
			class StoreSuppression		{file = "\soldierFSM\functions\misc\fn_StoreSuppression.sqf"};
			class onSuppression			{file = "\soldierFSM\functions\misc\fn_onSuppression.sqf"};
			class Roll					{file = "\soldierFSM\functions\misc\fn_Roll.sqf"};
			class unitData				{file = "\soldierFSM\functions\misc\fn_unitData.sqf"};
			class sinCosPos				{file = "\soldierFSM\functions\misc\fn_sinCosPos.sqf"};
			
			class initReaction			{file = "\soldierFSM\functions\misc\fn_initReaction.sqf"};
			class groupData				{file = "\soldierFSM\functions\misc\fn_groupData.sqf"};
			class manAvailable          {file = "\soldierFSM\functions\misc\fn_manAvailable.sqf"};
			class soundReaction         {file = "\soldierFSM\functions\misc\fn_soundReaction.sqf"};
			class forceMoveToPos		{file = "\soldierFSM\functions\misc\fn_forceMoveToPos.sqf"};
			class manLoaded             {file = "\soldierFSM\functions\misc\fn_manLoaded.sqf"};
			class unitInDoor            {file = "\soldierFSM\functions\misc\fn_unitInDoor.sqf"};
			class isRealMan             {file = "\soldierFSM\functions\misc\fn_isRealMan.sqf"};
			class targetVisible         {file = "\soldierFSM\functions\misc\fn_targetVisible.sqf"};
			class allCurrentDestinations{file = "\soldierFSM\functions\misc\fn_allCurrentDestinations.sqf"};
			class vehicleData           {file = "\soldierFSM\functions\misc\fn_vehicleData.sqf"};
			class vehicleHeard          {file = "\soldierFSM\functions\misc\fn_vehicleHeard.sqf"};
			class manOverrunBy          {file = "\soldierFSM\functions\misc\fn_manOverrunBy.sqf"};
		};
		class taskManagement
		{
			class HandleSuppression 	{file = "\soldierFSM\functions\taskManagement\fn_HandleSuppression.sqf"};
			class TaskManager           {file = "\soldierFSM\functions\taskManagement\fn_TaskManager.sqf"};
			class tenSecondTasks		{file = "\soldierFSM\functions\taskManagement\fn_tenSecondTasks.sqf"};
			class unitTasks				{file = "\soldierFSM\functions\taskManagement\fn_unitTasks.sqf"};
			class vehicleTasks          {file = "\soldierFSM\functions\taskManagement\fn_vehicleTasks.sqf"};
			class updateVehicle         {file = "\soldierFSM\functions\taskManagement\fn_updateVehicle.sqf"};
			class groupTasks			{file = "\soldierFSM\functions\taskManagement\fn_groupTasks.sqf"};
			class handleGroupStance     {file = "\soldierFSM\functions\taskManagement\fn_handleGroupStance.sqf"};
			class deleteDeadData        {file = "\soldierFSM\functions\taskManagement\fn_deleteDeadData.sqf"};
			
		};

		class projectileHandling
		{
			class reactToExplosion      {file = "\soldierFSM\functions\projectileHandling\fn_reactToExplosion.sqf"};
			class addCrater             {file = "\soldierFSM\functions\projectileHandling\fn_addCrater.sqf"};
			class handleBulletImpact    {file = "\soldierFSM\functions\projectileHandling\fn_handleBulletImpact.sqf"};
			class handleExplosion       {file = "\soldierFSM\functions\projectileHandling\fn_handleExplosion.sqf"};
		};

		class curator
		{
			class zWPplaced             {file = "\soldierFSM\functions\curator\fn_zWPplaced.sqf"};
			class zWPdeleted            {file = "\soldierFSM\functions\curator\fn_zWPdeleted.sqf"};
		};
		
		class eventHandlers
		{
			class SuppressedEH			{file = "\soldierFSM\functions\eventHandlers\fn_SuppressedEH.sqf"};
			class hitEH					{file = "\soldierFSM\functions\eventHandlers\fn_hitEH.sqf"};
			class firedEH				{file = "\soldierFSM\functions\eventHandlers\fn_firedEH.sqf"};
			class endHealEH				{file = "\soldierFSM\functions\eventHandlers\fn_endHealEH.sqf"};
			class curatorEH             {file = "\soldierFSM\functions\eventHandlers\fn_curatorEH.sqf"};
			class spottedCustomEH		{file = "\soldierFSM\functions\eventHandlers\fn_spottedCustomEH.sqf"};
			class enemySpotted          {file = "\soldierFSM\functions\eventHandlers\fn_enemySpotted.sqf"};
			class unitKilled            {file = "\soldierFSM\functions\eventHandlers\fn_unitKilled.sqf"};
			class unitCreated           {file = "\soldierFSM\functions\eventHandlers\fn_unitCreated.sqf"};
			class projectileEH			{file = "\soldierFSM\functions\eventHandlers\fn_projectileEH.sqf"};
			class explosionEH			{file = "\soldierFSM\functions\eventHandlers\fn_explosionEH.sqf"};
			class bulletEH			    {file = "\soldierFSM\functions\eventHandlers\fn_bulletEH.sqf"};
			class vehicleFiredEh        {file = "\soldierFSM\functions\eventHandlers\fn_vehicleFiredEh.sqf"};
			class enemyDetected			{file = "\soldierFSM\functions\eventHandlers\fn_enemyDetected.sqf"};
			class gameLoaded            {file = "\soldierFSM\functions\eventHandlers\fn_gameLoaded.sqf"; preInit = 1};
			class gameLoadedWarning     {file = "\soldierFSM\functions\eventHandlers\fn_gameLoadedWarning.sqf";};
		};

		class dodging
		{
			class dodgeEnded			{file = "\soldierFSM\functions\dodging\fn_dodgeEnded.sqf"};
			class EndDodge				{file = "\soldierFSM\functions\dodging\fn_EndDodge.sqf"};
			class Dodge					{file = "\soldierFSM\functions\dodging\fn_Dodge.sqf"};
			class GetDodgePos			{file = "\soldierFSM\functions\dodging\fn_GetDodgePos.sqf"};
			class canDodge				{file = "\soldierFSM\functions\dodging\fn_canDodge.sqf"};
			class getLateralPos			{file = "\soldierFSM\functions\dodging\fn_getLateralPos.sqf"};
			class groupCanDodge         {file = "\soldierFSM\functions\dodging\fn_groupCanDodge.sqf"};
			class forceCoverDodge       {file = "\soldierFSM\functions\dodging\fn_forceCoverDodge.sqf"};
			
			
		};
		
		class flinching 
		{
			class canFlinch				{file = "\soldierFSM\functions\flinching\fn_canFlinch.sqf"};
			class endFlinch				{file = "\soldierFSM\functions\flinching\fn_endFlinch.sqf"};
			class flinch 				{file = "\soldierFSM\functions\flinching\fn_flinch.sqf"};
			class bigBulletFlinch		{file = "\soldierFSM\functions\flinching\fn_BigBulletFlinch.sqf"};
			class standardFlinch		{file = "\soldierFSM\functions\flinching\fn_standardFlinch.sqf"};
			class execStandardFlinch	{file = "\soldierFSM\functions\flinching\fn_execStandardFlinch.sqf"};
			class normalizeStance		{file = "\soldierFSM\functions\flinching\fn_normalizeStance.sqf"};
			class bigFlinchCover        {file = "\soldierFSM\functions\flinching\fn_bigFlinchCover.sqf"};
			
		};

		class reactiveFire
		{
			class canReactFire			{file = "\soldierFSM\functions\reactiveFire\fn_canReactFire.sqf"};
			class reactFire				{file = "\soldierFSM\functions\reactiveFire\fn_reactFire.sqf"};
			class endReactiveFire		{file = "\soldierFSM\functions\reactiveFire\fn_endReactiveFire.sqf"};
			class directReactFire		{file = "\soldierFSM\functions\reactiveFire\fn_directReactFire.sqf"};
			class unitTounitForcedFire	{file = "\soldierFSM\functions\reactiveFire\fn_unitTounitForcedFire.sqf"};
			class unitAimedAtTarget		{file = "\soldierFSM\functions\reactiveFire\fn_unitAimedAtTarget.sqf"};
			class unitWeaponDir			{file = "\soldierFSM\functions\reactiveFire\fn_unitWeaponDir.sqf"};
			class multiplyReactionFire	{file = "\soldierFSM\functions\reactiveFire\fn_multiplyReactionFire.sqf"};
		};

		class startEngagement
		{
			//cover-folder
			class getCoverPos            {file = "\soldierFSM\functions\startEngagement\takeCover\fn_getCoverPos.sqf"};
			class fightInitCover		 {file = "\soldierFSM\functions\startEngagement\takeCover\fn_fightInitCover.sqf"};
			class takeCover				 {file = "\soldierFSM\functions\startEngagement\takeCover\fn_takeCover.sqf"};
			class endTakeCover        	 {file = "\soldierFSM\functions\startEngagement\takeCover\fn_endTakeCover.sqf"};
			class selectCoverPos         {file = "\soldierFSM\functions\startEngagement\takeCover\fn_selectCoverPos.sqf"};
			class postCoverActions       {file = "\soldierFSM\functions\startEngagement\takeCover\fn_postCoverActions.sqf"};
			class initTakeCover          {file = "\soldierFSM\functions\startEngagement\takeCover\fn_initTakeCover.sqf"};
			class stayInCover            {file = "\soldierFSM\functions\startEngagement\takeCover\fn_stayInCover.sqf"};
			class endStayInCover         {file = "\soldierFSM\functions\startEngagement\takeCover\fn_endStayInCover.sqf"};
			class eventTriggeredCover    {file = "\soldierFSM\functions\startEngagement\takeCover\fn_eventTriggeredCover.sqf"};

			//hide-folder
			class findHidePos            {file = "\soldierFSM\functions\startEngagement\hide\fn_findHidePos.sqf"};
			class hideFromVehicle        {file = "\soldierFSM\functions\startEngagement\hide\fn_hideFromVehicle.sqf"};
			class initHideFromVeh        {file = "\soldierFSM\functions\startEngagement\hide\fn_initHideFromVeh.sqf"};
			class moveToHidePos          {file = "\soldierFSM\functions\startEngagement\hide\fn_moveToHidePos.sqf"};
			class doHide                 {file = "\soldierFSM\functions\startEngagement\hide\fn_doHide.sqf"};
			class doHideCQB              {file = "\soldierFSM\functions\startEngagement\hide\fn_doHideCQB.sqf"};
			class execHiding             {file = "\soldierFSM\functions\startEngagement\hide\fn_execHiding.sqf"};

			//this-folder
			class AtSpecialistInitFight  {file = "\soldierFSM\functions\startEngagement\fn_AtSpecialistInitFight.sqf"};
			class targetInfWithLauncher  {file = "\soldierFSM\functions\startEngagement\fn_targetInfWithLauncher.sqf"};
			class reactTovehicles        {file = "\soldierFSM\functions\startEngagement\fn_reactTovehicles.sqf"};
			class unkillableEnemyVehicle {file = "\soldierFSM\functions\startEngagement\fn_unkillableEnemyVehicle.sqf"};
			class eyelidTrench			 {file = "\soldierFSM\functions\startEngagement\fn_eyelidTrench.sqf"};
			class getEnemyVehicles       {file = "\soldierFSM\functions\startEngagement\fn_getEnemyVehicles.sqf"};
			class specialInitFightActions{file = "\soldierFSM\functions\startEngagement\fn_specialInitFightActions.sqf"};
			class machineGunInitFight    {file = "\soldierFSM\functions\startEngagement\fn_machineGunInitFight.sqf"};
			class supressPositions       {file = "\soldierFSM\functions\startEngagement\fn_supressPositions.sqf"};
		}

		class init
		{
			class serverInit			{file = "\soldierFSM\functions\init\fn_serverInit.sqf"};
			class initSettings			{file = "\soldierFSM\functions\init\fn_initSettings.sqf"};
			class postConfig			{file = "\soldierFSM\functions\init\fn_postConfig.sqf"};
			class initClient			{file = "\soldierFSM\functions\init\fn_initClient.sqf"};
			class initSFSM				{file = "\soldierFSM\functions\init\fn_initSFSM.sqf"; 		postInit = 1};
			class InitMan				{file = "\soldierFSM\functions\init\fn_InitMan.sqf"};
			class initGroup             {file = "\soldierFSM\functions\init\fn_initGroup.sqf"};
			class initVehicle           {file = "\soldierFSM\functions\init\fn_initVehicle.sqf"};
		};

		
		//PapaReaps HC.
		class headlessClient {
            file = "\soldierFSM\functions\headlessClient";
            class hcCheck { postInit = 1; description = "Headless Client check"; };
            class hcTracker { description = "Monitors the state of Headless Clients"; };
        };
		
		class debug
		{
			class 3dDebug				{file = "\soldierFSM\functions\debug\fn_3dDebug.sqf"};
			class 3DdebugText			{file = "\soldierFSM\functions\debug\fn_3DdebugText.sqf"};
			class actionColor			{file = "\soldierFSM\functions\debug\fn_actionColor.sqf"};
			class drawObjectMarker      {file = "\soldierFSM\functions\debug\fn_drawObjectMarker.sqf"};
			class multiple3dmarkers     {file = "\soldierFSM\functions\debug\fn_multiple3dmarkers.sqf"};
			class battlefield3d			{file = "\soldierFSM\functions\debug\fn_battlefield3d.sqf"};
			class man3dInfo             {file = "\soldierFSM\functions\debug\fn_man3dInfo.sqf"};
			class debugMessage			{file = "\soldierFSM\functions\debug\fn_debugMessage.sqf"};
			class hunkerObj3d			{file = "\soldierFSM\functions\debug\fn_hunkerObj3d.sqf"};
			class manInfo               {file = "\soldierFSM\functions\debug\fn_manInfo.sqf"};
			class logSettings           {file = "\soldierFSM\functions\debug\fn_logSettings.sqf"};
			class deleteWarning         {file = "\soldierFSM\functions\debug\fn_deleteWarning.sqf"};
		};
		
		class healing
		{
			class proneHeal				{file = "\soldierFSM\functions\healing\fn_proneHeal.sqf"};
			class endSelfHeal			{file = "\soldierFSM\functions\healing\fn_endSelfHeal.sqf"};
			class canSelfHeal			{file = "\soldierFSM\functions\healing\fn_canSelfHeal.sqf"};
		};
		class battlefield
		{
			class InitBattlefield		  {file = "\soldierFSM\functions\battlefield\fn_InitBattlefield.sqf"};
			class battlefieldPostInit	  {file = "\soldierFSM\functions\battlefield\fn_battlefieldPostInit.sqf"};
			class battlefieldEnd		  {file = "\soldierFSM\functions\battlefield\fn_battlefieldEnd.sqf"};
			class getZones				  {file = "\soldierFSM\functions\battlefield\fn_getZones.sqf"};
			class getZone				  {file = "\soldierFSM\functions\battlefield\fn_getZone.sqf"};
			class getCoverPositionsLight  {file = "\soldierFSM\functions\battlefield\fn_getCoverPositionsLight.sqf"};
			class clusterCoverPosLight    {file = "\soldierFSM\functions\battlefield\fn_clusterCoverPosLight.sqf"};
			class battlefieldRadius       {file = "\soldierFSM\functions\battlefield\fn_battlefieldRadius.sqf"};
			class nearestBattle			  {file = "\soldierFSM\functions\battlefield\fn_nearestBattle.sqf"};
			class battleInitType          {file = "\soldierFSM\functions\battlefield\fn_battleInitType.sqf"};
			class battlefieldVariables    {file = "\soldierFSM\functions\battlefield\fn_battlefieldVariables.sqf"};
			class updateBattlefield       {file = "\soldierFSM\functions\battlefield\fn_updateBattlefield.sqf"};
			class sidesFromString         {file = "\soldierFSM\functions\battlefield\fn_sidesFromString.sqf"};
			class battlingUnits           {file = "\soldierFSM\functions\battlefield\fn_battlingUnits.sqf"};
			class battleEnded             {file = "\soldierFSM\functions\battlefield\fn_battleEnded.sqf"};
			class battleFieldUpdater      {file = "\soldierFSM\functions\battlefield\fn_battleFieldUpdater.sqf"};
			class triggerBattleOnShot	  {file = "\soldierFSM\functions\battlefield\fn_triggerBattleOnShot.sqf"};
			class canTriggerBattleShot	  {file = "\soldierFSM\functions\battlefield\fn_canTriggerBattleShot.sqf"};
			class canSpotInitBattle       {file = "\soldierFSM\functions\battlefield\fn_canSpotInitBattle.sqf"};
			class excludeCpos  			  {file = "\soldierFSM\functions\battlefield\fn_excludeCpos.sqf"};
			class getBattlefield		  {file = "\soldierFSM\functions\battlefield\fn_getBattlefield.sqf"};
			class getEnemyPositions		  {file = "\soldierFSM\functions\battlefield\fn_getEnemyPositions.sqf"};
			class updateHunkerObjects	  {file = "\soldierFSM\functions\battlefield\fn_updateHunkerObjects.sqf"};
			class initGrid                {file = "\soldierFSM\functions\battlefield\fn_initGrid.sqf"};
			class updateGrid              {file = "\soldierFSM\functions\battlefield\fn_updateGrid.sqf"};
			class AddWeaponsToBattlefield {file = "\soldierFSM\functions\battlefield\fn_AddWeaponsToBattlefield.sqf"};
			class emergencyRearm          {file = "\soldierFSM\functions\battlefield\fn_emergencyRearm.sqf"};
			class getBattlefieldWeapon    {file = "\soldierFSM\functions\battlefield\fn_getBattlefieldWeapon.sqf"};
			class pickUpWeapon            {file = "\soldierFSM\functions\battlefield\fn_pickUpWeapon.sqf"};
			class canPickUpWeapon         {file = "\soldierFSM\functions\battlefield\fn_canPickUpWeapon.sqf"};
			class endWeaponPickup         {file = "\soldierFSM\functions\battlefield\fn_endWeaponPickup.sqf"};
			class useLightScan            {file = "\soldierFSM\functions\battlefield\fn_useLightScan.sqf"};
			class battleFieldCQB          {file = "\soldierFSM\functions\battlefield\fn_battleFieldCQB.sqf"};
		};
		
		class markers
		{
			class posMarker				{file = "\soldierFSM\functions\markers\fn_posMarker.sqf"};
			class drawCircle			{file = "\soldierFSM\functions\markers\fn_drawCircle.sqf"};
			class bfDebugMarkers		{file = "\soldierFSM\functions\markers\fn_bfDebugMarkers.sqf"};
			class drawCoverPositions	{file = "\soldierFSM\functions\markers\fn_drawCoverPositions.sqf"};
		};

		class objectData
		{
			class glRifle				{file = "\soldierFSM\functions\objectData\fn_glRifle.sqf"};
			class ObjStance				{file = "\soldierFSM\functions\objectData\fn_ObjStance.sqf"};
			class areaData				{file = "\soldierFSM\functions\objectData\fn_areaData.sqf"};
			class getMapObjects			{file = "\soldierFSM\functions\objectData\fn_getMapObjects.sqf"};
			class excludedMapObject		{file = "\soldierFSM\functions\objectData\fn_excludedMapObject.sqf"};
			class filterMapObjects		{file = "\soldierFSM\functions\objectData\fn_filterMapObjects.sqf"};
			class terrainObjData		{file = "\soldierFSM\functions\objectData\fn_terrainObjData.sqf"};
			class squadAsset			{file = "\soldierFSM\functions\objectData\fn_squadAsset.sqf"};
			class hasAmmoForWeapon      {file = "\soldierFSM\functions\objectData\fn_hasAmmoForWeapon.sqf"};
		};
		class hunkerDown
		{
			class getHunkerObject		{file = "\soldierFSM\functions\hunkerDown\fn_getHunkerObject.sqf"};
			class initHunker			{file = "\soldierFSM\functions\hunkerDown\fn_initHunker.sqf"};
			class isHunkerObject        {file = "\soldierFSM\functions\hunkerDown\fn_isHunkerObject.sqf"};
			class hunkAvailable			{file = "\soldierFSM\functions\hunkerDown\fn_hunkAvailable.sqf"};
			class getAvHunkObject		{file = "\soldierFSM\functions\hunkerDown\fn_getAvHunkObject.sqf"};
			class filterHunkerObjects	{file = "\soldierFSM\functions\hunkerDown\fn_filterHunkerObjects.sqf"};
			class hunkObjHash	        {file = "\soldierFSM\functions\hunkerDown\fn_hunkObjHash.sqf"};
			class hunkerFSM				{file = "\soldierFSM\functions\hunkerDown\fn_hunkerFSM.sqf"};
			class hunkerFsmStatus		{file = "\soldierFSM\functions\hunkerDown\fn_hunkerFsmStatus.sqf"};
			class addHunkerObjData		{file = "\soldierFSM\functions\hunkerDown\fn_addHunkerObjData.sqf"};
			class setHobjPositions		{file = "\soldierFSM\functions\hunkerDown\fn_setHobjPositions.sqf"};
			class moveToHunkerPos		{file = "\soldierFSM\functions\hunkerDown\fn_moveToHunkerPos.sqf"};
			class endHunker				{file = "\soldierFSM\functions\hunkerDown\fn_endHunker.sqf"};
			class initHunkerFSM			{file = "\soldierFSM\functions\hunkerDown\fn_initHunkerFSM.sqf"};
			class handleHunkerStatus	{file = "\soldierFSM\functions\hunkerDown\fn_handleHunkerStatus.sqf"};
			class randomHunkerInit		{file = "\soldierFSM\functions\hunkerDown\fn_randomHunkerInit.sqf"};

		};
	};

	class Tcore
	{
		class core
		{
			
			
			class average				{file = "\soldierFSM\functions\core\fn_average.sqf"};
			class decimals				{file = "\soldierFSM\functions\core\fn_decimals.sqf"};
			class addZ					{file = "\soldierFSM\functions\core\fn_addZ.sqf"};
			class roundPos				{file = "\soldierFSM\functions\core\fn_roundPos.sqf"};
			class avgPos				{file = "\soldierFSM\functions\core\fn_avgPos.sqf"};
			class get360Positions		{file = "\soldierFSM\functions\core\fn_get360Positions.sqf"};
			class nearestPos			{file = "\soldierFSM\functions\core\fn_nearestPos.sqf"};
			class getMidpoint           {file = "\soldierFSM\functions\core\fn_getMidpoint.sqf"};
			class sinCosPos				{file = "\soldierFSM\functions\core\fn_sinCosPos.sqf"};
			
			class formatDir 			{file = "\soldierFSM\functions\core\fn_formatDir.sqf"};
			class avgRelDir				{file = "\soldierFSM\functions\core\fn_avgRelDir.sqf"};
			class inDirRange 			{file = "\soldierFSM\functions\core\fn_inDirRange.sqf"};
			
			class object3DShape			{file = "\soldierFSM\functions\core\fn_object3DShape.sqf"};
			class objPosData			{file = "\soldierFSM\functions\core\fn_objPosData.sqf"};
			class simpleObjectType		{file = "\soldierFSM\functions\core\fn_simpleObjectType.sqf"};

			class clusterPos			{file = "\soldierFSM\functions\core\fn_clusterPos.sqf"};
			class allClustersInRadius	{file = "\soldierFSM\functions\core\fn_allClustersInRadius.sqf"};
			class ClusterTerrainObjects	{file = "\soldierFSM\functions\core\fn_ClusterTerrainObjects.sqf"};
			class positionsClusterArr	{file = "\soldierFSM\functions\core\fn_positionsClusterArr.sqf"};
			class clusterSize			{file = "\soldierFSM\functions\core\fn_clusterSize.sqf"};
			class clusterMarker			{file = "\soldierFSM\functions\core\fn_clusterMarker.sqf"};
			class ClusterSides			{file = "\soldierFSM\functions\core\fn_ClusterSides.sqf"};
			
			class ClusterUnits			{file = "\soldierFSM\functions\core\fn_ClusterUnits.sqf"};
			class ClusterVehicles		{file = "\soldierFSM\functions\core\fn_ClusterVehicles.sqf"};
			class clusterGroups         {file = "\soldierFSM\functions\core\fn_clusterGroups.sqf"};

			class unitCoverPosArr		{file = "\soldierFSM\functions\core\fn_unitCoverPosArr.sqf"};
			class posCoverPosArr		{file = "\soldierFSM\functions\core\fn_posCoverPosArr.sqf"};
			class coverPosStance		{file = "\soldierFSM\functions\core\fn_coverPosStance.sqf"};
			class objCoverPosLight		{file = "\soldierFSM\functions\core\fn_objCoverPosLight.sqf"};
			class coverPosSimple		{file = "\soldierFSM\functions\core\fn_coverPosSimple.sqf"};
			class visibleFromPositions	{file = "\soldierFSM\functions\core\fn_visibleFromPositions.sqf"};
			
			class debugMessage			{file = "\soldierFSM\functions\core\fn_debugMessage.sqf"};
			class closestLocationName	{file = "\soldierFSM\functions\core\fn_closestLocationName.sqf"};
			class getLocationNamePos	{file = "\soldierFSM\functions\core\fn_getLocationNamePos.sqf"};
			
			class describeDir			{file = "\soldierFSM\functions\core\fn_describeDir.sqf"};
			class describeDistance		{file = "\soldierFSM\functions\core\fn_describeDistance.sqf"};
			class stringToVarName		{file = "\soldierFSM\functions\core\fn_stringToVarName.sqf"};
			class areaName				{file = "\soldierFSM\functions\core\fn_areaName.sqf"};			
			
			class toArrFromArr			{file = "\soldierFSM\functions\core\fn_toArrFromArr.sqf"};
			
			class nearKnownEnemies      {file = "\soldierFSM\functions\core\fn_nearKnownEnemies.sqf"};
			class knownDirToEnemy       {file = "\soldierFSM\functions\core\fn_knownDirToEnemy.sqf"};
			class getLosTarget			{file = "\soldierFSM\functions\core\fn_getLosTarget.sqf"};
			class deadCrew				{file = "\soldierFSM\functions\core\fn_deadCrew.sqf"};
			class grid100Pos            {file = "\soldierFSM\functions\core\fn_grid100Pos.sqf"};
			class substringsPresent     {file = "\soldierFSM\functions\core\fn_substringsPresent.sqf"};
			class playerLedGrp          {file = "\soldierFSM\functions\core\fn_playerLedGrp.sqf"};
			class isPlayer				{file = "\soldierFSM\functions\core\fn_isPlayer.sqf"};

			class toggleAiMoveInhibitors{file = "\soldierFSM\functions\core\fn_toggleAiMoveInhibitors.sqf"};
			class deadMenInArea         {file = "\soldierFSM\functions\core\fn_deadMenInArea.sqf"};
			class nearSoldiers          {file = "\soldierFSM\functions\core\fn_nearSoldiers.sqf"};

			class nilNull				{file = "\soldierFSM\functions\core\fn_nilNull.sqf"};
			class posArrToPathPosArr    {file = "\soldierFSM\functions\core\fn_posArrToPathPosArr.sqf"};
			class avgHeight             {file = "\soldierFSM\functions\core\fn_avgHeight.sqf"};
			class unitArrAimPositions   {file = "\soldierFSM\functions\core\fn_unitArrAimPositions.sqf"};
			class posFromObjArr         {file = "\soldierFSM\functions\core\fn_posFromObjArr.sqf"};
		};
	};
};